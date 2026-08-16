import 'package:flutter/material.dart';
import '../models/app_scope.dart';
import '../routes.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/buttons.dart';
import '../widgets/misc_widgets.dart';
import '../widgets/otp_row.dart';
import '../widgets/screen_chrome.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scope = AppScope.of(context);
    void goTo(String route) => Navigator.of(context).pushReplacementNamed(route);

    return StandardScreenScaffold(
      onBack: () => goTo(Routes.method),
      activeStep: 2,
      bodyCrossAxisAlignment: CrossAxisAlignment.center,
      bodyChildren: [
        Eyebrow(text: scope.t('mcEyebrow'), centered: true),
        Text(scope.t('otpTitle'), style: AppTextStyles.hTitle(color: AppColors.voidOf(context)), textAlign: TextAlign.center),
        Padding(
          padding: const EdgeInsets.only(top: 6, bottom: 22),
          child: Text(scope.t('otpSub'), style: AppTextStyles.hSub.copyWith(color: AppColors.inkSoftOf(context)), textAlign: TextAlign.center),
        ),
        const EmailChip(text: '✉️ sa***@gmail.com'),
        const OtpRow(),
        ResendRow(centered: true, onResend: () {}),
      ],
      bottomChildren: [
        PrimaryButton(label: scope.t('otpConfirmBtn'), onTap: () => goTo(Routes.createAccount)),
      ],
    );
  }
}
