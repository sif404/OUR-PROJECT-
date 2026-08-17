import 'package:flutter/material.dart';

/// AXN colour tokens.
///
/// These tokens mirror the AXN visual system and the original
/// CSS variables used in the prototype. Keep the names stable
/// so screen code remains traceable to the design system.
class AppColors {
  AppColors._();

  // ============================================================
  // Core AXN palette
  // ============================================================

  static const white = Color(0xFFFFFFFF);

  static const paper = Color(0xFFFBF6EA);
  static const stone = Color(0xFFF1E7D2);
  static const stoneLine = Color(0xFFE4D5B7);

  static const void_ = Color(0xFF17130E);
  static const inkSoft = Color(0xFF6E6152);

  // AXN primary dark/red surface.
  // Previously this was the dark navy/purple (#211D4C).
  static const dome = Color(0xFFCE1126);

  // Deeper supporting tone — intentionally kept dark.
  static const domeDeep = Color(0xFF0E0C24);

  // AXN red family.
  static const ember = Color(0xFFCE1126);
  static const emberDeep = Color(0xFFA10E1F);
  static const emberTint = Color(0xFFFBE1E4);

  // Gold family.
  static const gold = Color(0xFFC79A46);
  static const goldSoft = Color(0xFFF1E2BC);

  // Green / success family.
  static const pitch = Color(0xFF1F6B4A);
  static const pitchTint = Color(0xFFE3F2EA);

  // Brand / flag reds.
  static const flagRed = Color(0xFFCE1126);
  static const brandRed = Color(0xFFCE1126);
  static const brandRedDeep = Color(0xFF9C0C1B);

  // ============================================================
  // Onboarding / splash palette
  // ============================================================

  static const paper1 = Color(0xFFFBF6EA);
  static const paper2 = Color(0xFFEEE2C6);
  static const paper3 = Color(0xFFDFCEA3);

  static const ink = Color(0xFF2B2420);
  static const muted = Color(0xFF8C7D63);

  static const illustration = Color(0xFFC9AD82);
  static const illustrationDark = Color(0xFFB89968);

  // ============================================================
  // Extra literals used by the prototype
  // ============================================================

  static const crestGradTop = Color(0xFFC1493C);
  static const crestGradBottom = Color(0xFF7C2620);

  static const successCheck = Color(0xFF1F6B4A);

  static const notchBlack = Color(0xFF17161A);

  static const loginBadgeStart = Color(0xFF17130E);
  static const loginBadgeEnd = Color(0xFF2A2116);

  static const flagBlack = Color(0xFF17130E);
  static const flagGreen = Color(0xFF0B7A3C);

  static const disabledPrimaryOpacity = 0.4;

  // ============================================================
  // Shadows
  // ============================================================

  static const shadowCardColor = Color(0x3D17130E);
  static const shadowBtnColor = Color(0x73B5502E);

  // ============================================================
  // Legacy / supporting primary tokens
  // ============================================================

  static const Color primary = Color(0xFFB54D3F);
  static const Color primaryLight = Color(0xFFE4A853);
  static const Color dangerGlow = Color(0xFFEF6B6B);

  // ============================================================
  // Theme-aware colours
  // ============================================================

  static Color getBg(bool isLight) {
    return isLight
        ? const Color(0xFFF7F6F2)
        : const Color(0xFF121212);
  }

  static Color getSurf(bool isLight) {
    return isLight
        ? Colors.white
        : const Color(0xFF1A1A1A);
  }

  static Color getBorder(bool isLight) {
    return isLight
        ? const Color(0xFFE7E2DA)
        : const Color(0xFF3A3A3A);
  }

  static Color getTextP(bool isLight) {
    return isLight
        ? const Color(0xFF111111)
        : const Color(0xFFF2F1EC);
  }

  static Color getTextS(bool isLight) {
    return isLight
        ? const Color(0xFF6E6E6E)
        : const Color(0xFFB6B2A8);
  }

  static Color bg(BuildContext context) {
    return getBg(
      Theme.of(context).brightness == Brightness.light,
    );
  }

  static Color surf(BuildContext context) {
    return getSurf(
      Theme.of(context).brightness == Brightness.light,
    );
  }

  static Color border(BuildContext context) {
    return getBorder(
      Theme.of(context).brightness == Brightness.light,
    );
  }

  static Color textP(BuildContext context) {
    return getTextP(
      Theme.of(context).brightness == Brightness.light,
    );
  }

  static Color textS(BuildContext context) {
    return getTextS(
      Theme.of(context).brightness == Brightness.light,
    );
  }

  // ============================================================
  // Paper / ink helpers
  // ============================================================

  static Color getPaper(bool isLight) {
    return isLight
        ? paper
        : const Color(0xFF1E1E1E);
  }

  static Color getPaperTone(bool isLight) {
    return isLight
        ? paper
        : const Color(0xFF252525);
  }

  static Color getInkSoft(bool isLight) {
    return isLight
        ? inkSoft
        : const Color(0xFF9A9690);
  }

  static Color getVoid(bool isLight) {
    return isLight
        ? void_
        : const Color(0xFFF2F1EC);
  }

  static Color getInk(bool isLight) {
    return isLight
        ? ink
        : const Color(0xFFE8E6DF);
  }

  static Color getMuted(bool isLight) {
    return isLight
        ? muted
        : const Color(0xFFB6B2A8);
  }

  static Color paperOf(BuildContext context) {
    return getPaper(
      Theme.of(context).brightness == Brightness.light,
    );
  }

  static Color inkSoftOf(BuildContext context) {
    return getInkSoft(
      Theme.of(context).brightness == Brightness.light,
    );
  }

  static Color voidOf(BuildContext context) {
    return getVoid(
      Theme.of(context).brightness == Brightness.light,
    );
  }

  static Color inkOf(BuildContext context) {
    return getInk(
      Theme.of(context).brightness == Brightness.light,
    );
  }

  static Color mutedOf(BuildContext context) {
    return getMuted(
      Theme.of(context).brightness == Brightness.light,
    );
  }

  static Color stoneLineOf(BuildContext context) {
    return getBorder(
      Theme.of(context).brightness == Brightness.light,
    );
  }

  // ============================================================
  // Ember / red helpers
  // ============================================================

  static Color getPrimaryText(bool isLight) {
    return isLight
        ? ember
        : const Color(0xFFE63946);
  }

  static Color primaryTextOf(BuildContext context) {
    return getPrimaryText(
      Theme.of(context).brightness == Brightness.light,
    );
  }

  static Color getEmberTint(bool isLight) {
    return isLight
        ? emberTint
        : const Color(0xFF3F1218);
  }

  static Color emberTintOf(BuildContext context) {
    return getEmberTint(
      Theme.of(context).brightness == Brightness.light,
    );
  }

  // ============================================================
  // Gold helpers
  // ============================================================

  static Color getGoldTint(bool isLight) {
    return isLight
        ? goldSoft
        : const Color(0xFF332A14);
  }

  static Color goldTintOf(BuildContext context) {
    return getGoldTint(
      Theme.of(context).brightness == Brightness.light,
    );
  }

  // ============================================================
  // Pitch / green helpers
  // ============================================================

  static Color getPitchTint(bool isLight) {
    return isLight
        ? pitchTint
        : const Color(0xFF0E2E20);
  }

  static Color pitchTintOf(BuildContext context) {
    return getPitchTint(
      Theme.of(context).brightness == Brightness.light,
    );
  }

  // ============================================================
  // Paper gradient helpers
  // ============================================================

  static Color getPaper1(bool isLight) {
    return isLight
        ? paper1
        : const Color(0xFF1E1E1E);
  }

  static Color getPaper2(bool isLight) {
    return isLight
        ? paper2
        : const Color(0xFF171717);
  }

  static Color getPaper3(bool isLight) {
    return isLight
        ? paper3
        : const Color(0xFF121212);
  }

  static List<Color> getPaperGradient(bool isLight) {
    return isLight
        ? [paper1, paper2, paper3]
        : [
            const Color(0xFF1E1E1E),
            const Color(0xFF171717),
            const Color(0xFF121212),
          ];
  }

  // ============================================================
  // Card / page helpers
  // ============================================================

  static Color getCardBg(bool isLight) {
    return isLight
        ? white
        : const Color(0xFF212121);
  }

  static Color cardBgOf(BuildContext context) {
    return getCardBg(
      Theme.of(context).brightness == Brightness.light,
    );
  }

  static Color getPageBg(bool isLight) {
    return isLight
        ? white
        : const Color(0xFF121212);
  }

  static Color pageBgOf(BuildContext context) {
    return getPageBg(
      Theme.of(context).brightness == Brightness.light,
    );
  }

  // ============================================================
  // Icon badge helpers
  // ============================================================

  static Color getIconBadgeBg(bool isLight) {
    return isLight
        ? void_
        : const Color(0xFF2A2A2A);
  }

  static Color iconBadgeBgOf(BuildContext context) {
    return getIconBadgeBg(
      Theme.of(context).brightness == Brightness.light,
    );
  }
}