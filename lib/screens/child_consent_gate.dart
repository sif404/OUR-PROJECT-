import 'package:flutter/material.dart';

import '../models/groups_scope.dart';
import '../routes.dart';

class ChildConsentGate extends StatefulWidget {
  const ChildConsentGate({super.key, required this.childBuilder});

  final WidgetBuilder childBuilder;

  @override
  State<ChildConsentGate> createState() => _ChildConsentGateState();
}

class _ChildConsentGateState extends State<ChildConsentGate> {
  var _allowed = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _ensureConsent());
  }

  Future<void> _ensureConsent() async {
    final groups = GroupsScope.of(context);
    if (groups.hasFamilyConsent) {
      if (mounted) setState(() => _allowed = true);
      return;
    }

    if (!groups.hasFamilyGroup) {
      Navigator.of(context).pushReplacementNamed(
        Routes.profile,
        arguments: const {
          'highlightCreateGroup': true,
          'scrollToMyGroups': true,
        },
      );
      return;
    }

    final accepted = await Navigator.of(context).pushNamed<bool>(Routes.familyConsent);
    if (!mounted) return;

    if (accepted != true) {
      Navigator.of(context).maybePop();
      return;
    }

    groups.grantFamilyConsent();
    setState(() => _allowed = true);
  }

  @override
  Widget build(BuildContext context) {
    if (_allowed) return widget.childBuilder(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: const Center(child: CircularProgressIndicator()),
    );
  }
}
