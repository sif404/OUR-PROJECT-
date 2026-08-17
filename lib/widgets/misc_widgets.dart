import 'package:flutter/material.dart';
import '../models/app_scope.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// .eyebrow — small mono ember label with a 14x2 gold tick before it.
class Eyebrow extends StatelessWidget {
  const Eyebrow({super.key, required this.text, this.centered = false});
  final String text;
  final bool centered;

  @override
  Widget build(BuildContext context) {
    final row = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 14, height: 2, color: AppColors.gold),
        const SizedBox(width: 6),
        Text(text.toUpperCase(), style: AppTextStyles.eyebrow.copyWith(color: AppColors.primaryTextOf(context))),
      ],
    );
    return Padding(
      padding: const EdgeInsetsDirectional.only(bottom: 6),
      child: centered ? Center(child: row) : row,
    );
  }
}

/// .email-chip — pill-shaped mono chip, e.g. "✉️ sa***@gmail.com".
class EmailChip extends StatelessWidget {
  const EmailChip({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.only(top: 4),
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.paperOf(context),
        border: Border.all(color: AppColors.stoneLineOf(context)),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(text, style: AppTextStyles.emailChip.copyWith(color: AppColors.voidOf(context))),
    );
  }
}

/// .guest-note — ember-tint rounded panel of body copy.
class GuestNote extends StatelessWidget {
  const GuestNote({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Container(
      width: double.infinity,
      margin: const EdgeInsetsDirectional.only(top: 16),
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.emberTintOf(context),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: AppTextStyles.guestNote.copyWith(
          color: isLight ? AppColors.emberDeep : const Color(0xFFFFD3D7),
        ),
      ),
    );
  }
}

/// .resend — "Didn't get the code? **Resend (0:45)**"
class ResendRow extends StatelessWidget {
  const ResendRow({super.key, this.centered = true, this.onResend});
  final bool centered;
  final VoidCallback? onResend;

  @override
  Widget build(BuildContext context) {
    final scope = AppScope.of(context);
    final text = RichText(
      textAlign: centered ? TextAlign.center : TextAlign.start,
      text: TextSpan(
        style: AppTextStyles.resend.copyWith(color: AppColors.inkSoftOf(context)),
        children: [
          TextSpan(text: scope.t('resendPrefix')),
          TextSpan(
            text: scope.t('resendAction'),
            style: AppTextStyles.resendBold.copyWith(color: AppColors.primaryTextOf(context)),
          ),
        ],
      ),
    );
    return Padding(
      padding: const EdgeInsetsDirectional.only(top: 10),
      child: GestureDetector(onTap: onResend, child: text),
    );
  }
}

/// .footer-note — faint mono centered caption at the very bottom of a
/// screen (used sparingly; kept available for parity with the source CSS).
class FooterNote extends StatelessWidget {
  const FooterNote({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(24, 14, 24, 6),
      child: Text(
        text.toUpperCase(),
        textAlign: TextAlign.center,
        style: AppTextStyles.footerNote.copyWith(color: AppColors.mutedOf(context)),
      ),
    );
  }
}

/// .divider — "―――  or  ―――" horizontal rule with centered label.
class TextDivider extends StatelessWidget {
  const TextDivider({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 22),
      child: Row(
        children: [
          Expanded(child: Divider(color: AppColors.stoneLineOf(context), height: 1)),
          Padding(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
            child: Text(text, style: AppTextStyles.divider.copyWith(color: AppColors.inkSoftOf(context))),
          ),
          Expanded(child: Divider(color: AppColors.stoneLineOf(context), height: 1)),
        ],
      ),
    );
  }
}
