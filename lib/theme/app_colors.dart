import 'package:flutter/material.dart';

/// Colour tokens copied 1:1 from the `:root{ ... }` CSS custom properties
/// in AXN_App_Flow.html. Keep these named identically to their CSS
/// counterparts (converted to camelCase) so screen code stays traceable
/// back to the source stylesheet.
class AppColors {
  AppColors._();

  static const white = Color(0xFFFFFFFF);
  static const paper = Color(0xFFFBF6EA);
  static const stone = Color(0xFFF1E7D2);
  static const stoneLine = Color(0xFFE4D5B7);
  static const void_ = Color(0xFF17130E);
  static const inkSoft = Color(0xFF6E6152);
  static const dome = Color(0xFF211D4C);
  static const domeDeep = Color(0xFF0E0C24);
  static const ember = Color(0xFFCE1126);
  static const emberDeep = Color(0xFFA10E1F);
  static const emberTint = Color(0xFFFBE1E4);
  static const gold = Color(0xFFC79A46);
  static const goldSoft = Color(0xFFF1E2BC);
  static const pitch = Color(0xFF1F6B4A);
  static const pitchTint = Color(0xFFE3F2EA);
  static const flagRed = Color(0xFFCE1126);
  static const brandRed = Color(0xFFCE1126);
  static const brandRedDeep = Color(0xFF9C0C1B);

  // onboarding / splash palette
  static const paper1 = Color(0xFFFBF6EA);
  static const paper2 = Color(0xFFEEE2C6);
  static const paper3 = Color(0xFFDFCEA3);
  static const ink = Color(0xFF2B2420);
  static const muted = Color(0xFF8C7D63);
  static const illustration = Color(0xFFC9AD82);
  static const illustrationDark = Color(0xFFB89968);

  // extra literals used inline in the HTML that aren't CSS vars
  static const crestGradTop = Color(0xFFC1493C);
  static const crestGradBottom = Color(0xFF7C2620);
  static const successCheck = Color(0xFF1F6B4A);
  static const notchBlack = Color(0xFF17161A);
  static const loginBadgeStart = Color(0xFF17130E); // var(--void)
  static const loginBadgeEnd = Color(0xFF2A2116);
  static const flagBlack = Color(0xFF17130E); // crest-ribbon b1 (--void)
  static const flagGreen = Color(0xFF0B7A3C); // crest-ribbon b3
  static const disabledPrimaryOpacity = 0.4;

  static const shadowCardColor = Color(0x3D17130E); // rgba(23,19,14,.24)
  static const shadowBtnColor = Color(0x73B5502E); // rgba(181,80,46,.45)

  static const Color primary = Color(0xFFB54D3F);
  static const Color primaryLight = Color(0xFFE4A853);
  static const Color dangerGlow = Color(0xFFEF6B6B);

  static Color getBg(bool isLight) => isLight ? const Color(0xFFF7F6F2) : const Color(0xFF121212);
  static Color getSurf(bool isLight) => isLight ? Colors.white : const Color(0xFF1A1A1A);
  static Color getBorder(bool isLight) => isLight ? const Color(0xFFE7E2DA) : const Color(0xFF3A3A3A);
  static Color getTextP(bool isLight) => isLight ? const Color(0xFF111111) : const Color(0xFFF2F1EC);
  static Color getTextS(bool isLight) => isLight ? const Color(0xFF6E6E6E) : const Color(0xFFB6B2A8);

  static Color bg(BuildContext context) => getBg(Theme.of(context).brightness == Brightness.light);
  static Color surf(BuildContext context) => getSurf(Theme.of(context).brightness == Brightness.light);
  static Color border(BuildContext context) => getBorder(Theme.of(context).brightness == Brightness.light);
  static Color textP(BuildContext context) => getTextP(Theme.of(context).brightness == Brightness.light);
  static Color textS(BuildContext context) => getTextS(Theme.of(context).brightness == Brightness.light);

  static Color getPaper(bool isLight) => isLight ? paper : const Color(0xFF1E1E1E);
  static Color getPaperTone(bool isLight) => isLight ? paper : const Color(0xFF252525);
  static Color getInkSoft(bool isLight) => isLight ? inkSoft : const Color(0xFF9A9690);
  static Color getVoid(bool isLight) => isLight ? void_ : const Color(0xFFF2F1EC);
  static Color getInk(bool isLight) => isLight ? ink : const Color(0xFFE8E6DF);
  static Color getMuted(bool isLight) => isLight ? muted : const Color(0xFFB6B2A8);

  static Color paperOf(BuildContext context) => getPaper(Theme.of(context).brightness == Brightness.light);
  static Color inkSoftOf(BuildContext context) => getInkSoft(Theme.of(context).brightness == Brightness.light);
  static Color voidOf(BuildContext context) => getVoid(Theme.of(context).brightness == Brightness.light);
  static Color inkOf(BuildContext context) => getInk(Theme.of(context).brightness == Brightness.light);
  static Color mutedOf(BuildContext context) => getMuted(Theme.of(context).brightness == Brightness.light);
  static Color stoneLineOf(BuildContext context) => getBorder(Theme.of(context).brightness == Brightness.light);

  static Color getPrimaryText(bool isLight) => isLight ? ember : const Color(0xFFE63946);
  static Color primaryTextOf(BuildContext context) => getPrimaryText(Theme.of(context).brightness == Brightness.light);

  static Color getEmberTint(bool isLight) => isLight ? emberTint : const Color(0xFF3F1218);
  static Color emberTintOf(BuildContext context) => getEmberTint(Theme.of(context).brightness == Brightness.light);

  static Color getGoldTint(bool isLight) => isLight ? goldSoft : const Color(0xFF332A14);
  static Color goldTintOf(BuildContext context) => getGoldTint(Theme.of(context).brightness == Brightness.light);

  static Color getPitchTint(bool isLight) => isLight ? pitchTint : const Color(0xFF0E2E20);
  static Color pitchTintOf(BuildContext context) => getPitchTint(Theme.of(context).brightness == Brightness.light);

  static Color getPaper1(bool isLight) => isLight ? paper1 : const Color(0xFF1E1E1E);
  static Color getPaper2(bool isLight) => isLight ? paper2 : const Color(0xFF171717);
  static Color getPaper3(bool isLight) => isLight ? paper3 : const Color(0xFF121212);

  static List<Color> getPaperGradient(bool isLight) => isLight
      ? [paper1, paper2, paper3]
      : [const Color(0xFF1E1E1E), const Color(0xFF171717), const Color(0xFF121212)];

  static Color getCardBg(bool isLight) => isLight ? white : const Color(0xFF212121);
  static Color cardBgOf(BuildContext context) => getCardBg(Theme.of(context).brightness == Brightness.light);

  static Color getPageBg(bool isLight) => isLight ? white : const Color(0xFF121212);
  static Color pageBgOf(BuildContext context) => getPageBg(Theme.of(context).brightness == Brightness.light);

  static Color getIconBadgeBg(bool isLight) => isLight ? void_ : const Color(0xFF2A2A2A);
  static Color iconBadgeBgOf(BuildContext context) => getIconBadgeBg(Theme.of(context).brightness == Brightness.light);
}
