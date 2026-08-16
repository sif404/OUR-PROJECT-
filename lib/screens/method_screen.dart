import 'package:flutter/material.dart';
import '../models/app_scope.dart';
import '../routes.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/buttons.dart';
import '../widgets/method_card.dart';
import '../widgets/misc_widgets.dart';
import '../widgets/screen_chrome.dart';

class MethodScreen extends StatefulWidget {
  const MethodScreen({super.key});

  @override
  State<MethodScreen> createState() => _MethodScreenState();
}

class _MethodScreenState extends State<MethodScreen> {
  String _chosen = 'qr'; // matches JS: let chosenMethod default 'qr' (m-qr starts .selected)

  void _goTo(String route) => Navigator.of(context).pushReplacementNamed(route);

  void _proceed() => _goTo(_chosen == 'qr' ? Routes.qr : Routes.manual);

  @override
  Widget build(BuildContext context) {
    final scope = AppScope.of(context);
    return StandardScreenScaffold(
      onBack: () => _goTo(Routes.welcome),
      activeStep: 0,
      bodyChildren: [
        Eyebrow(text: scope.t('m1Eyebrow')),
        Text(scope.t('m1Title'), style: AppTextStyles.hTitle(color: AppColors.voidOf(context))),
        Padding(padding: const EdgeInsets.only(top: 6, bottom: 22), child: Text(scope.t('m1Sub'), style: AppTextStyles.hSub.copyWith(color: AppColors.inkSoftOf(context)))),
        MethodCard(
          icon: '▦',
          title: scope.t('m1QrTitle'),
          description: scope.t('m1QrDesc'),
          selected: _chosen == 'qr',
          onTap: () => setState(() => _chosen = 'qr'),
        ),
        MethodCard(
          icon: '✎',
          title: scope.t('m1ManualTitle'),
          description: scope.t('m1ManualDesc'),
          selected: _chosen == 'manual',
          onTap: () => setState(() => _chosen = 'manual'),
        ),
      ],
      bottomChildren: [
        PrimaryButton(label: scope.t('btnContinue'), onTap: _proceed),
      ],
    );
  }
}
