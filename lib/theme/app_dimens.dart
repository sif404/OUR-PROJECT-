import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Layout tokens copied from the CSS: radii, shadows and the phone
/// reference size the HTML prototype was designed at (device: 390x844,
/// scaled 0.82 for the desktop demo — Flutter runs at 1:1 native scale).
class AppDimens {
  AppDimens._();

  static const radiusLg = 26.0;
  static const radiusMd = 16.0;
  static const radiusSm = 10.0;

  // --shadow-card: 0 20px 45px -20px rgba(23,19,14,.24)
  static const shadowCard = [
    BoxShadow(
      color: AppColors.shadowCardColor,
      blurRadius: 45,
      offset: Offset(0, 20),
      spreadRadius: -20,
    ),
  ];

  // --shadow-btn: 0 12px 26px -10px rgba(181,80,46,.45)
  static const shadowBtn = [
    BoxShadow(
      color: AppColors.shadowBtnColor,
      blurRadius: 26,
      offset: Offset(0, 12),
      spreadRadius: -10,
    ),
  ];

  // .btn-primary box-shadow: 0 12px 26px -10px rgba(124,38,32,.5)
  static const shadowBtnPrimary = [
    BoxShadow(
      color: Color(0x807C2620),
      blurRadius: 26,
      offset: Offset(0, 12),
      spreadRadius: -10,
    ),
  ];

  // .btn-teal box-shadow: 0 10px 24px -10px rgba(31,107,74,.5)
  static const shadowBtnTeal = [
    BoxShadow(
      color: Color(0x801F6B4A),
      blurRadius: 24,
      offset: Offset(0, 10),
      spreadRadius: -10,
    ),
  ];

  // notif-panel: 0 24px 48px -18px rgba(23,19,14,.28)
  static const shadowNotifPanel = [
    BoxShadow(
      color: Color(0x4717130E),
      blurRadius: 48,
      offset: Offset(0, 24),
      spreadRadius: -18,
    ),
  ];

  // device shadow (kept for reference; not used since we skip the phone frame)
  static const shadowDevice = [
    BoxShadow(color: Color(0x66000000), blurRadius: 90, offset: Offset(0, 40), spreadRadius: -30),
  ];

  static const double cardElevation = 2.0;
  static const double cardRadius = 16.0;
  static const double btnRadius = 16.0;
  static const double fieldRadius = 12.0;
}
