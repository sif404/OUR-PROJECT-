import 'package:flutter/material.dart';
import '../models/app_scope.dart';
import '../routes.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/app_field.dart';
import '../widgets/buttons.dart';
import '../widgets/misc_widgets.dart';
import '../widgets/screen_chrome.dart';

class ManualCodeScreen extends StatelessWidget {
  const ManualCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scope = AppScope.of(context);
    void goTo(String route) => Navigator.of(context).pushReplacementNamed(route);

    return StandardScreenScaffold(
      onBack: () => goTo(Routes.manual),
      activeStep: 2,
      bodyChildren: [
        Eyebrow(text: scope.t('mcEyebrow')),
        Text(scope.t('mcTitle'), style: AppTextStyles.hTitle(color: AppColors.voidOf(context))),
        Padding(padding: const EdgeInsets.only(top: 6, bottom: 22), child: Text(scope.t('mcSub'), style: AppTextStyles.hSub.copyWith(color: AppColors.inkSoftOf(context)))),
        const EmailChip(text: '✉️ sa***@gmail.com'),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: AppField(label: scope.t('mcLabel'), placeholder: '••••••', mono: true),
        ),
        ResendRow(centered: false, onResend: () {}),
      ],
      bottomChildren: [
        PrimaryButton(label: scope.t('mcVerifyBtn'), onTap: () => goTo(Routes.createAccount)),
      ],
    );
  }
}
