import 'package:flutter/material.dart';
import '../models/app_scope.dart';
import '../routes.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/app_field.dart';
import '../widgets/buttons.dart';
import '../widgets/misc_widgets.dart';
import '../widgets/screen_chrome.dart';

class ManualScreen extends StatelessWidget {
  const ManualScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scope = AppScope.of(context);
    void goTo(String route) => Navigator.of(context).pushReplacementNamed(route);

    return StandardScreenScaffold(
      onBack: () => goTo(Routes.method),
      activeStep: 1,
      bodyChildren: [
        Eyebrow(text: scope.t('m1ManualTitle')),
        Text(scope.t('manualTitle'), style: AppTextStyles.hTitle(color: AppColors.voidOf(context))),
        Padding(padding: const EdgeInsets.only(top: 6, bottom: 22), child: Text(scope.t('manualSub'), style: AppTextStyles.hSub.copyWith(color: AppColors.inkSoftOf(context)))),
        AppField(label: scope.t('manualLabel'), placeholder: 'JFA26-XXXXXX', mono: true),
      ],
      bottomChildren: [
        PrimaryButton(label: scope.t('btnContinue'), onTap: () => goTo(Routes.manualCode)),
      ],
    );
  }
}
