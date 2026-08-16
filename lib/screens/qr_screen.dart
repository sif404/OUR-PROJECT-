import 'package:flutter/material.dart';
import '../models/app_scope.dart';
import '../routes.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/buttons.dart';
import '../widgets/misc_widgets.dart';
import '../widgets/scan_frame.dart';
import '../widgets/screen_chrome.dart';

class QrScreen extends StatelessWidget {
  const QrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scope = AppScope.of(context);
    void goTo(String route) => Navigator.of(context).pushReplacementNamed(route);

    return StandardScreenScaffold(
      onBack: () => goTo(Routes.method),
      activeStep: 1,
      bodyCrossAxisAlignment: CrossAxisAlignment.center,
      bodyChildren: [
        Eyebrow(text: scope.t('qrEyebrow'), centered: true),
        Text(scope.t('qrTitle'), style: AppTextStyles.hTitle(color: AppColors.voidOf(context)), textAlign: TextAlign.center),
        Padding(
          padding: const EdgeInsets.only(top: 6, bottom: 22),
          child: Text(scope.t('qrSub'), style: AppTextStyles.hSub.copyWith(color: AppColors.inkSoftOf(context)), textAlign: TextAlign.center),
        ),
        const Center(child: ScanFrame()),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: EmailChip(text: scope.t('qrChip')),
        ),
      ],
      bottomChildren: [
        PrimaryButton(label: scope.t('qrDetected'), onTap: () => goTo(Routes.otp)),
        GhostButtonBlock(label: scope.t('qrManualInstead'), onTap: () => goTo(Routes.manual)),
      ],
    );
  }
}
