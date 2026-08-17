import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Text styles mapped from the HTML/CSS classes. Font families:
///   'El Messiri'            -> headings (h-title, stadium-name, notif-title...)
///   'IBM Plex Sans Arabic'  -> body copy (h-sub, method-desc, inputs...)
///   'IBM Plex Mono'         -> eyebrow/labels/mono chips (city-name, otp...)
///   'Cairo'                 -> onboarding-only text (ob-title etc.)
///
/// Arabic text sometimes flows through mono/heading styles (e.g. the
/// eyebrow or city-name labels get translated to Arabic too) so every
/// helper declares an Arabic-capable fallback the way a browser would
/// silently substitute a font for missing glyphs.
class AppTextStyles {
  AppTextStyles._();

  static final _arabicFallback = GoogleFonts.ibmPlexSansArabic().fontFamily!;

  static TextStyle elMessiri({
    required double fontSize,
    required FontWeight fontWeight,
    Color color = AppColors.void_,
    double? height,
    double? letterSpacing,
  }) =>
      GoogleFonts.elMessiri(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        height: height,
        letterSpacing: letterSpacing,
      ).copyWith(fontFamilyFallback: [_arabicFallback]);

  static TextStyle plexArabic({
    required double fontSize,
    FontWeight fontWeight = FontWeight.w400,
    Color color = AppColors.inkSoft,
    double? height,
  }) =>
      GoogleFonts.ibmPlexSansArabic(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        height: height,
      );

  static TextStyle mono({
    required double fontSize,
    FontWeight fontWeight = FontWeight.w400,
    Color color = AppColors.inkSoft,
    double? letterSpacing,
    double? height,
  }) =>
      GoogleFonts.ibmPlexMono(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: letterSpacing,
        height: height,
      ).copyWith(fontFamilyFallback: [_arabicFallback]);

  static TextStyle cairo({
    required double fontSize,
    required FontWeight fontWeight,
    Color color = AppColors.ink,
    double? letterSpacing,
    double? height,
  }) =>
      GoogleFonts.cairo(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: letterSpacing,
        height: height,
      );

  // ---- concrete named styles lifted directly from the CSS ----

  // h1.h-title
  static TextStyle hTitle({Color color = AppColors.void_}) => elMessiri(
        fontSize: 25,
        fontWeight: FontWeight.w700,
        color: color,
        height: 1.3,
      );

  // p.h-sub
  static TextStyle hSub = plexArabic(fontSize: 13.5, color: AppColors.inkSoft, height: 1.6);

  // .eyebrow
  static TextStyle eyebrow = mono(
    fontSize: 10.5,
    fontWeight: FontWeight.w600,
    color: AppColors.ember,
    letterSpacing: 1.26, // .12em of 10.5px
  );

  // .city-name
  static TextStyle cityName = mono(
    fontSize: 10.5,
    color: AppColors.brandRed,
    letterSpacing: 1.89, // .18em of 10.5px
  );

  // .stadium-name
  static TextStyle stadiumName = elMessiri(
    fontSize: 19,
    fontWeight: FontWeight.w700,
    color: AppColors.void_,
    height: 1.35,
  );

  // .tagline
  static TextStyle tagline = plexArabic(fontSize: 12.5, color: AppColors.inkSoft, height: 1.55);

  // .btn (El Messiri 700 15)
  static TextStyle btn({Color color = AppColors.white}) =>
      elMessiri(fontSize: 15, fontWeight: FontWeight.w700, color: color);

  // .btn-ghost
  static TextStyle btnGhost({double fontSize = 13}) =>
      elMessiri(fontSize: fontSize, fontWeight: FontWeight.w700, color: AppColors.brandRed);

  // .guest-link
  static TextStyle guestLink = plexArabic(
    fontSize: 12.5,
    fontWeight: FontWeight.w600,
    color: AppColors.inkSoft,
  );

  // .guest-note
  static TextStyle guestNote = plexArabic(fontSize: 13, color: AppColors.emberDeep, height: 1.6);

  // .method-title
  static TextStyle methodTitle = elMessiri(fontSize: 14.5, fontWeight: FontWeight.w700);

  // .method-desc
  static TextStyle methodDesc = plexArabic(fontSize: 12, color: AppColors.inkSoft, height: 1.5);

  // .notif-panel-head
  static TextStyle notifPanelHead = mono(
    fontSize: 10,
    color: AppColors.inkSoft,
    letterSpacing: 1.0,
  );

  // .notif-title
  static TextStyle notifTitle = elMessiri(fontSize: 13, fontWeight: FontWeight.w700);

  // .notif-body
  static TextStyle notifBody = plexArabic(fontSize: 12, color: AppColors.inkSoft, height: 1.45);

  // .lang-toggle span
  static TextStyle langToggle = plexArabic(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.brandRed,
  );

  // .field label
  static TextStyle fieldLabel = mono(
    fontSize: 10.5,
    color: AppColors.inkSoft,
    letterSpacing: 0.84,
  );

  // .field input text
  static TextStyle fieldInput = plexArabic(fontSize: 14.5, color: AppColors.void_);
  static TextStyle fieldInputMono = mono(fontSize: 14.5, color: AppColors.void_);

  // .field .hint
  static TextStyle fieldHint = plexArabic(fontSize: 11, color: AppColors.inkSoft);

  // .otp-box
  static TextStyle otpBox({bool filled = false}) => mono(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: filled ? AppColors.ember : AppColors.void_,
      );

  // .resend
  static TextStyle resend = plexArabic(fontSize: 12.5, color: AppColors.inkSoft);
  static TextStyle resendBold =
      plexArabic(fontSize: 12.5, fontWeight: FontWeight.w700, color: AppColors.emberDeep);

  // .email-chip
  static TextStyle emailChip = mono(fontSize: 12, color: AppColors.void_);

  // .bind-text b / span
  static TextStyle bindTextTitle = elMessiri(fontSize: 13.5, fontWeight: FontWeight.w700);
  static TextStyle bindTextSub = plexArabic(fontSize: 11.5, color: AppColors.inkSoft);

  // .divider
  static TextStyle divider = plexArabic(fontSize: 11.5, color: AppColors.inkSoft);

  // .footer-note
  static TextStyle footerNote = mono(
    fontSize: 9.5,
    color: const Color(0xFFB8AD97),
    letterSpacing: 0.95,
  );

  // splash
  static TextStyle splashWord = cairo(fontSize: 26, fontWeight: FontWeight.w800, letterSpacing: -0.3);
  static TextStyle splashWordRed = splashWord.copyWith(color: AppColors.brandRed);
  static TextStyle splashTag = cairo(fontSize: 13, fontWeight: FontWeight.w400, color: AppColors.muted, letterSpacing: 0.4);

  // onboarding
  static TextStyle obSkip = cairo(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.brandRed);
  static TextStyle obTitle = cairo(fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.ink);
  static TextStyle obSubtitle = cairo(fontSize: 13.5, fontWeight: FontWeight.w400, color: AppColors.muted, height: 1.55);
  static TextStyle obNextLabel = cairo(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.brandRed);

  // step counter for method/eyebrow re-used already above.
}
