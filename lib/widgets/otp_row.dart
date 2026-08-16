import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// .otp-row / .otp-box — 6 boxes, 44x54, filled ones show ember border/text.
/// Matches the static demo state baked into the HTML: digits 4,8,1 filled,
/// remaining 3 show a bullet placeholder.
class OtpRow extends StatelessWidget {
  const OtpRow({super.key, this.values = const ['4', '8', '1', '•', '•', '•'], this.filledCount = 3});
  final List<String> values;
  final int filledCount;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(values.length, (i) {
          final filled = i < filledCount;
          return Padding(
            padding: EdgeInsetsDirectional.only(start: i == 0 ? 0 : 10),
            child: Container(
              width: 44,
              height: 54,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: filled ? AppColors.cardBgOf(context) : AppColors.paperOf(context),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: filled ? cs.primary : AppColors.stoneLineOf(context), width: 1.6),
              ),
              child: Text(values[i], style: AppTextStyles.otpBox(filled: filled).copyWith(color: filled ? AppColors.primaryTextOf(context) : AppColors.voidOf(context))),
            ),
          );
        }),
      ),
    );
  }
}
