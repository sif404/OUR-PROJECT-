import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'groups.dart';

class GroupsController extends ChangeNotifier {
  GroupsController({List<GroupData>? initialGroups}) : _groups = List.of(initialGroups ?? const []);

  final List<GroupData> _groups;

  List<GroupData> get groups => List.unmodifiable(_groups);

  bool get hasFamilyGroup => _groups.any((g) => g.type == GroupType.family);

  bool get hasFamilyConsent => _groups.any((g) => g.type == GroupType.family && g.consentGranted);

  void grantFamilyConsent() {
    var changed = false;
    for (var i = 0; i < _groups.length; i++) {
      final g = _groups[i];
      if (g.type != GroupType.family || g.consentGranted) continue;
      changed = true;
      _groups[i] = GroupData(
        id: g.id,
        name: g.name,
        type: g.type,
        members: g.members,
        consentGranted: true,
      );
    }
    if (changed) notifyListeners();
  }

  void addGroup(GroupData group) {
    _groups.add(group);
    notifyListeners();
  }

  String nextGroupId({required GroupType type}) {
    final prefix = type == GroupType.family ? 'family' : 'group';
    final rand = math.Random().nextInt(999999).toString().padLeft(6, '0');
    return '$prefix-$rand';
  }
}

class GroupsScope extends InheritedNotifier<GroupsController> {
  const GroupsScope({
    super.key,
    required GroupsController controller,
    required super.child,
  }) : super(notifier: controller);

  static GroupsController of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<GroupsScope>();
    assert(scope != null, 'GroupsScope.of() called with no GroupsScope ancestor');
    return scope!.notifier!;
  }

  static GroupsController? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<GroupsScope>()?.notifier;
  }
}
