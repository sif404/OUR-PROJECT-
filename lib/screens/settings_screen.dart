import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/theme_controller.dart';
import '../theme/app_theme_data.dart';
import '../models/app_scope.dart';

/// ============================================================================
/// SettingsScreen
///
/// Faithful Flutter migration of `settings.html`.
/// Visual source of truth: the `.frame` / `.screen#screen-main` markup and its
/// `<style>` block. Colors, spacing, radii, typography and interaction states
/// below are copied 1:1 from the CSS custom properties and rules.
///
/// NOT included (per task scope — "Settings screen only"):
///   - Safe zones list / add-edit zone screen (#screen-safezones, #screen-zoneadd)
///   - Change PIN screen (#screen-pin)
///   These are reachable only via row taps in the HTML; here they are exposed
///   as VoidCallback? props so real navigation can be wired in later.
/// ============================================================================

/// -------------------- Design tokens (from :root CSS vars) --------------------
class _Palette {
  final Color page;
  final Color card;
  final Color cardAlt;
  final Color text;
  final Color textSec;
  final Color textMut;
  final Color border;
  final Color accent; // CSS var --blue, actually a red (#CE1126)
  final Color accentStrong; // --blue-strong, pressed state
  final Color accentTint; // --blue-tint
  final Color trackOff;

  const _Palette({
    required this.page,
    required this.card,
    required this.cardAlt,
    required this.text,
    required this.textSec,
    required this.textMut,
    required this.border,
    required this.accent,
    required this.accentStrong,
    required this.accentTint,
    required this.trackOff,
  });

  // Values taken directly from the `:root` block (light) and the
  // `setDarkVars(true)` branch of the <script> (dark).
  static const light = _Palette(
    page: Color(0xFFFFFFFF),
    card: Color(0xFFFAFAFA),
    cardAlt: Color(0xFFF3E9EA),
    text: Color(0xFF131417),
    textSec: Color(0xFF7A7E88),
    textMut: Color(0xFFA6A9B2),
    border: Color(0xFFEDE7E7),
    accent: Color(0xFFCE1126),
    accentStrong: Color(0xFFA50E1F),
    accentTint: Color(0xFFFBEAEC),
    trackOff: Color(0xFFD9DCE3),
  );

  static const dark = _Palette(
    page: Color(0xFF101114),
    card: Color(0xFF1B1D22),
    cardAlt: Color(0xFF2B1416),
    text: Color(0xFFF2F2F0),
    textSec: Color(0xFF9A9CA5),
    textMut: Color(0xFF6E7078),
    border: Color(0xFF2B2E36),
    accent: Color(0xFFE31B33),
    accentStrong: Color(0xFFCE1126),
    accentTint: Color(0xFF2B1416),
    trackOff: Color(0xFF33353D),
  );
}

/// Theme mode chosen inside the segmented control. `system` resolves against
/// the platform brightness, exactly like `mq.matches` in the HTML.
enum _AppThemeChoice { light, dark, system }

extension _AppThemeChoiceX on _AppThemeChoice {
  AxnThemeMode toMode() {
    switch (this) {
      case _AppThemeChoice.light:
        return AxnThemeMode.light;
      case _AppThemeChoice.dark:
        return AxnThemeMode.dark;
      case _AppThemeChoice.system:
        return AxnThemeMode.system;
    }
  }

  static _AppThemeChoice fromMode(AxnThemeMode m) {
    switch (m) {
      case AxnThemeMode.light:
        return _AppThemeChoice.light;
      case AxnThemeMode.dark:
        return _AppThemeChoice.dark;
      case AxnThemeMode.system:
        return _AppThemeChoice.system;
    }
  }
}

/// Font-size steps from `#fontSeg` — values copied from `data-fs` / `data-fst`.
class _FontStep {
  final String labelKey;
  final double base;
  final double title;
  const _FontStep(this.labelKey, this.base, this.title);

  String label(BuildContext context) => AppScope.of(context).t(labelKey);
}

const List<_FontStep> _fontSteps = [
  _FontStep('settings_fontSmall', 14, 13),
  _FontStep('settings_fontDefault', 15, 14.5),
  _FontStep('settings_fontLarge', 17, 15.5),
  _FontStep('settings_fontXLarge', 19, 17),
];

const double _fsSub = 12.5; // --fs-sub — constant across all font-size steps
const double _fsH = 22; // --fs-h — constant across all font-size steps

/// ============================================================================
/// Public entry point
/// ============================================================================
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    super.key,
    this.onBack,
    this.onManageSafeZones,
    this.onChangePin,
    this.onHelpCenter,
    this.onContactSupport,
    this.onReportProblem,
    this.onTermsOfService,
    this.onPrivacyPolicy,
  });

  /// Top-left back button. In the HTML this is `data-nav="exit"`, a no-op in
  /// the prototype — left nullable so a real Navigator.pop can be supplied.
  final VoidCallback? onBack;

  /// "Manage safe zones" link-row -> `data-nav="safezones"`.
  final VoidCallback? onManageSafeZones;

  /// "Change PIN / password" row -> `data-nav="pin"`.
  final VoidCallback? onChangePin;

  /// "Help center / FAQ" row.
  final VoidCallback? onHelpCenter;

  /// "Contact support" row.
  final VoidCallback? onContactSupport;

  /// "Report a problem" row.
  final VoidCallback? onReportProblem;

  /// "Terms of service" row.
  final VoidCallback? onTermsOfService;

  /// "Privacy policy" row.
  final VoidCallback? onPrivacyPolicy;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // ---- Notification toggles (initial values copied from which rows carry
  // the `.switch.on` class in the HTML) ----
  bool _pushNotifications = true;
  bool _safeZoneAlerts = true;
  bool _groupActivityAlerts = true;
  bool _legacyCapsuleAlerts = false; // no `.on` class in source
  bool _shareLiveLocation = true;
  bool _biometricUnlock = true;

  // ---- Language segmented control (#langEn / #langAr) ----
  int _languageIndex = 0; // 0 = EN (active by default), 1 = AR

  // ---- Theme segmented control (#themeSeg) ----
  _AppThemeChoice _themeChoice = _AppThemeChoice.system;

  // ---- Font-size segmented control (#fontSeg) ----
  int _fontStepIndex = 1; // "Default" is `.active` in the source

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final ctrl = ProviderScope.containerOf(context, listen: false).read(themeControllerProvider);
      setState(() {
        _themeChoice = _AppThemeChoiceX.fromMode(ctrl.mode);
        _languageIndex = ctrl.languageCode == 'ar' ? 1 : 0;
      });
    });
  }

  bool get _resolvedIsDark {
    switch (_themeChoice) {
      case _AppThemeChoice.dark:
        return true;
      case _AppThemeChoice.light:
        return false;
      case _AppThemeChoice.system:
        return MediaQuery.platformBrightnessOf(context) == Brightness.dark;
    }
  }

  @override
  Widget build(BuildContext context) {
    final palette = _resolvedIsDark ? _Palette.dark : _Palette.light;
    final step = _fontSteps[_fontStepIndex];
    final scope = AppScope.of(context);

    // `.row-text .t` / `.h1` / `.seg-row .t` -> Playfair Display (serif head font)
    final headFont = GoogleFonts.playfairDisplay();
    // Everything else -> platform default sans (-apple-system / Segoe UI / Roboto)
    const bodyFontFamily = null; // inherit platform default

    return Scaffold(
      backgroundColor: palette.page,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsetsDirectional.fromSTEB(18, 6, 18, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _TopBar(
                title: scope.t('settings_title'),
                palette: palette,
                headFont: headFont,
                onBack: widget.onBack,
              ),
              const SizedBox(height: 14),

              // ---------------- Notifications ----------------
              _SectionLabel(scope.t('settings_notifications'), palette: palette, isFirst: true),
              _SettingsGroup(
                palette: palette,
                children: [
                  _SettingsRow(
                    title: scope.t('settings_pushTitle'),
                    subtitle: scope.t('settings_pushSub'),
                    palette: palette,
                    headFont: headFont,
                    fsTitle: step.title,
                    fsSub: _fsSub,
                    trailing: _CustomSwitch(
                      value: _pushNotifications,
                      palette: palette,
                      onChanged: (v) => setState(() => _pushNotifications = v),
                    ),
                  ),
                  _SettingsRow(
                    title: scope.t('settings_safeZoneTitle'),
                    subtitle: scope.t('settings_safeZoneSub'),
                    palette: palette,
                    headFont: headFont,
                    fsTitle: step.title,
                    fsSub: _fsSub,
                    trailing: _CustomSwitch(
                      value: _safeZoneAlerts,
                      palette: palette,
                      onChanged: (v) => setState(() => _safeZoneAlerts = v),
                    ),
                  ),
                  _SettingsRow(
                    title: scope.t('settings_groupActivityTitle'),
                    subtitle: scope.t('settings_groupActivitySub'),
                    palette: palette,
                    headFont: headFont,
                    fsTitle: step.title,
                    fsSub: _fsSub,
                    trailing: _CustomSwitch(
                      value: _groupActivityAlerts,
                      palette: palette,
                      onChanged: (v) =>
                          setState(() => _groupActivityAlerts = v),
                    ),
                  ),
                  _SettingsRow(
                    title: scope.t('settings_legacyCapsuleTitle'),
                    subtitle: scope.t('settings_legacyCapsuleSub'),
                    palette: palette,
                    headFont: headFont,
                    fsTitle: step.title,
                    fsSub: _fsSub,
                    trailing: _CustomSwitch(
                      value: _legacyCapsuleAlerts,
                      palette: palette,
                      onChanged: (v) =>
                          setState(() => _legacyCapsuleAlerts = v),
                    ),
                  ),
                  _LinkRow(
                    label: scope.t('settings_manageSafeZones'),
                    palette: palette,
                    fsSub: _fsSub,
                    onTap: widget.onManageSafeZones,
                  ),
                ],
              ),

              // ---------------- Preferences ----------------
              _SectionLabel(scope.t('settings_preferences'), palette: palette),
              _SettingsGroup(
                palette: palette,
                children: [
                  _SettingsRow(
                    title: scope.t('settings_language'),
                    palette: palette,
                    headFont: headFont,
                    fsTitle: step.title,
                    fsSub: _fsSub,
                    trailing: SizedBox(
                      width: 110,
                      child: _SegmentedControl(
                        options: [scope.t('settings_langEn'), scope.t('settings_langAr')],
                        selectedIndex: _languageIndex,
                        palette: palette,
                        onChanged: (i) {
                          setState(() => _languageIndex = i);
                          final ctrl = ProviderScope.containerOf(context, listen: false).read(themeControllerProvider);
                          ctrl.setLanguage(i == 1 ? 'ar' : 'en');
                          final scope = AppScope.of(context);
                          scope.setLang(i == 1 ? 'ar' : 'en');
                        },
                      ),
                    ),
                  ),
                  _SegRow(
                    title: scope.t('settings_theme'),
                    palette: palette,
                    headFont: headFont,
                    fsTitle: step.title,
                    child: _SegmentedControl(
                      options: [scope.t('settings_themeLight'), scope.t('settings_themeDark'), scope.t('settings_themeSystem')],
                      selectedIndex: _themeChoice.index,
                      palette: palette,
                      onChanged: (i) {
                        setState(() => _themeChoice = _AppThemeChoice.values[i]);
                        final ctrl = ProviderScope.containerOf(context, listen: false).read(themeControllerProvider);
                        ctrl.setMode(_themeChoice.toMode());
                      },
                    ),
                  ),
                ],
              ),

              // ---------------- Accessibility ----------------
              _SectionLabel(scope.t('settings_accessibility'), palette: palette),
              _SettingsGroup(
                palette: palette,
                children: [
                  _SegRow(
                    title: scope.t('settings_fontSize'),
                    palette: palette,
                    headFont: headFont,
                    fsTitle: step.title,
                    child: _SegmentedControl(
                      options: [scope.t('settings_fontSmall'), scope.t('settings_fontDefault'), scope.t('settings_fontLarge'), scope.t('settings_fontXLarge')],
                      selectedIndex: _fontStepIndex,
                      palette: palette,
                      onChanged: (i) => setState(() => _fontStepIndex = i),
                    ),
                  ),
                ],
              ),

              // ---------------- Location & sharing ----------------
              _SectionLabel(scope.t('settings_locationSharing'), palette: palette),
              _SettingsGroup(
                palette: palette,
                children: [
                  _SettingsRow(
                    title: scope.t('settings_shareLocationTitle'),
                    subtitle: scope.t('settings_shareLocationSub'),
                    palette: palette,
                    headFont: headFont,
                    fsTitle: step.title,
                    fsSub: _fsSub,
                    trailing: _CustomSwitch(
                      value: _shareLiveLocation,
                      palette: palette,
                      onChanged: (v) => setState(() => _shareLiveLocation = v),
                    ),
                    isLast: true,
                  ),
                ],
              ),

              // ---------------- Account & security ----------------
              _SectionLabel(scope.t('settings_accountSecurity'), palette: palette),
              _SettingsGroup(
                palette: palette,
                children: [
                  _SettingsRow(
                    title: scope.t('settings_changePin'),
                    palette: palette,
                    headFont: headFont,
                    fsTitle: step.title,
                    fsSub: _fsSub,
                    trailing: _Chevron(palette: palette),
                    onTap: widget.onChangePin,
                  ),
                  _SettingsRow(
                    title: scope.t('settings_biometricTitle'),
                    subtitle: scope.t('settings_biometricSub'),
                    palette: palette,
                    headFont: headFont,
                    fsTitle: step.title,
                    fsSub: _fsSub,
                    trailing: _CustomSwitch(
                      value: _biometricUnlock,
                      palette: palette,
                      onChanged: (v) => setState(() => _biometricUnlock = v),
                    ),
                    isLast: true,
                  ),
                ],
              ),

              // ---------------- Help & support ----------------
              _SectionLabel(scope.t('settings_helpSupport'), palette: palette),
              _SettingsGroup(
                palette: palette,
                children: [
                  _SettingsRow(
                    title: scope.t('settings_helpCenter'),
                    palette: palette,
                    headFont: headFont,
                    fsTitle: step.title,
                    fsSub: _fsSub,
                    trailing: _Chevron(palette: palette),
                    onTap: widget.onHelpCenter,
                  ),
                  _SettingsRow(
                    title: scope.t('settings_contactSupport'),
                    palette: palette,
                    headFont: headFont,
                    fsTitle: step.title,
                    fsSub: _fsSub,
                    trailing: _Chevron(palette: palette),
                    onTap: widget.onContactSupport,
                  ),
                  _SettingsRow(
                    title: scope.t('settings_reportProblem'),
                    palette: palette,
                    headFont: headFont,
                    fsTitle: step.title,
                    fsSub: _fsSub,
                    trailing: _Chevron(palette: palette),
                    onTap: widget.onReportProblem,
                    isLast: true,
                  ),
                ],
              ),

              // ---------------- About ----------------
              _SectionLabel(scope.t('settings_about'), palette: palette),
              _SettingsGroup(
                palette: palette,
                children: [
                  _SettingsRow(
                    title: scope.t('settings_version'),
                    palette: palette,
                    headFont: headFont,
                    fsTitle: step.title,
                    fsSub: _fsSub,
                    trailing: Text(
                      '1.0.0',
                      style: TextStyle(
                        fontFamily: bodyFontFamily,
                        fontSize: _fsSub,
                        color: palette.textSec,
                      ),
                    ),
                  ),
                  _SettingsRow(
                    title: scope.t('settings_terms'),
                    palette: palette,
                    headFont: headFont,
                    fsTitle: step.title,
                    fsSub: _fsSub,
                    trailing: _Chevron(palette: palette),
                    onTap: widget.onTermsOfService,
                  ),
                  _SettingsRow(
                    title: scope.t('settings_privacy'),
                    palette: palette,
                    headFont: headFont,
                    fsTitle: step.title,
                    fsSub: _fsSub,
                    trailing: _Chevron(palette: palette),
                    onTap: widget.onPrivacyPolicy,
                    isLast: true,
                  ),
                ],
              ),

              // ---------------- Footer ----------------
              const SizedBox(height: 22),
              Text(
                scope.t('settings_logoutNote'),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 11, color: palette.textMut),
              ),
              const SizedBox(height: 4),
            ],
          ),
        ),
      ),
    );
  }
}

/// ============================================================================
/// Private reusable widgets
/// ============================================================================

/// `.topbar` — circular back button (`.back`) + `.h1` title.
class _TopBar extends StatelessWidget {
  const _TopBar({
    required this.title,
    required this.palette,
    required this.headFont,
    this.onBack,
  });

  final String title;
  final _Palette palette;
  final TextStyle headFont;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    final scope = AppScope.of(context);
    return Row(
      children: [
        Semantics(
          button: true,
          label: scope.t('settings_back'),
          child: Material(
            color: palette.card,
            shape: const CircleBorder(),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: onBack,
              child: SizedBox(
                width: 34,
                height: 34,
                child: Icon(Icons.chevron_right, size: 20, color: palette.text),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: headFont.copyWith(
            fontSize: _fsH,
            fontWeight: FontWeight.w700,
            color: palette.text,
          ),
        ),
      ],
    );
  }
}

/// `.section-label` — uppercase small red/accent label above each `.group`.
class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text, {required this.palette, this.isFirst = false});

  final String text;
  final _Palette palette;
  final bool isFirst;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(2, isFirst ? 0 : 22, 2, 8),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          fontSize: _fsSub,
          fontWeight: FontWeight.w700,
          color: palette.accent,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}

/// `.group` — rounded card (radius 16, subtle shadow) that clips its
/// children so the bottom row's bottom border doesn't poke past the corner.
class _SettingsGroup extends StatelessWidget {
  const _SettingsGroup({required this.children, required this.palette});

  final List<Widget> children;
  final _Palette palette;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.only(bottom: 0),
      decoration: BoxDecoration(
        color: palette.card,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(20, 30, 60, 0.04),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(children: children),
    );
  }
}

/// `.row` (+ optional `.clickable`) — a single settings line: title/subtitle
/// on the left, arbitrary trailing control on the right. Draws its own
/// bottom border except when it is the last child in the group.
class _SettingsRow extends StatelessWidget {
  const _SettingsRow({
    required this.title,
    required this.palette,
    required this.headFont,
    required this.fsTitle,
    required this.fsSub,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.isLast = false,
  });

  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final _Palette palette;
  final TextStyle headFont;
  final double fsTitle;
  final double fsSub;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final content = Container(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 13),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : Border(bottom: BorderSide(color: palette.border, width: 1)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: headFont.copyWith(
                    fontSize: fsTitle,
                    fontWeight: FontWeight.w600,
                    color: palette.text,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 3),
                  Text(
                    subtitle!,
                    style: TextStyle(
                      fontSize: fsSub,
                      color: palette.textSec,
                      height: 1.35,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (trailing != null) ...[
            const SizedBox(width: 12),
            trailing!,
          ],
        ],
      ),
    );

    if (onTap == null) return content;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        splashColor: palette.cardAlt,
        highlightColor: palette.cardAlt,
        child: content,
      ),
    );
  }
}

/// `.seg-row` — a row whose full width is taken by a title above a
/// segmented control (used for Theme and Font size).
class _SegRow extends StatelessWidget {
  const _SegRow({
    required this.title,
    required this.palette,
    required this.headFont,
    required this.fsTitle,
    required this.child,
  });

  final String title;
  final _Palette palette;
  final TextStyle headFont;
  final double fsTitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: headFont.copyWith(
              fontSize: fsTitle,
              fontWeight: FontWeight.w600,
              color: palette.text,
            ),
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}

/// `.link-row` — bold accent-colored row with a top border and a chevron,
/// used for "Manage safe zones".
class _LinkRow extends StatelessWidget {
  const _LinkRow({
    required this.label,
    required this.palette,
    required this.fsSub,
    this.onTap,
  });

  final String label;
  final _Palette palette;
  final double fsSub;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        splashColor: palette.cardAlt,
        highlightColor: palette.cardAlt,
        child: Container(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: palette.border, width: 1)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: fsSub,
                  fontWeight: FontWeight.w700,
                  color: palette.accent,
                ),
              ),
              Icon(Icons.chevron_right, size: 16, color: palette.accent),
            ],
          ),
        ),
      ),
    );
  }
}

/// `.chev` — muted trailing chevron used on plain navigational rows.
class _Chevron extends StatelessWidget {
  const _Chevron({required this.palette});
  final _Palette palette;

  @override
  Widget build(BuildContext context) {
    return Icon(Icons.chevron_right, size: 18, color: palette.textMut);
  }
}

/// `.switch` / `.switch.on` / `.knob` — hand-built toggle matching the exact
/// 44x26 track / 20x20 knob geometry instead of Material's default `Switch`,
/// since the default widget's proportions and colors don't match the source.
class _CustomSwitch extends StatelessWidget {
  const _CustomSwitch({
    required this.value,
    required this.onChanged,
    required this.palette,
  });

  final bool value;
  final ValueChanged<bool> onChanged;
  final _Palette palette;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        onChanged(!value);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: 44,
        height: 26,
        padding: const EdgeInsetsDirectional.only(start: 3, end: 3, top: 3, bottom: 3),
        decoration: BoxDecoration(
          color: value ? palette.accent : palette.trackOff,
          borderRadius: BorderRadius.circular(20),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          alignment: value ? AlignmentDirectional.centerEnd : AlignmentDirectional.centerStart,
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// `.seg` — pill-shaped segmented control used for Language / Theme /
/// Font size. Equal-width segments, active segment filled with accent color.
class _SegmentedControl extends StatelessWidget {
  const _SegmentedControl({
    required this.options,
    required this.selectedIndex,
    required this.onChanged,
    required this.palette,
  });

  final List<String> options;
  final int selectedIndex;
  final ValueChanged<int> onChanged;
  final _Palette palette;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.only(start: 3, end: 3, top: 3, bottom: 3),
      decoration: BoxDecoration(
        color: palette.cardAlt,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: List.generate(options.length, (i) {
          final isActive = i == selectedIndex;
          return Expanded(
            child: Padding(
              padding: EdgeInsetsDirectional.only(end: i == options.length - 1 ? 0 : 2),
              child: Material(
                color: isActive ? palette.accent : Colors.transparent,
                borderRadius: BorderRadius.circular(9),
                child: InkWell(
                  borderRadius: BorderRadius.circular(9),
                  onTap: () => onChanged(i),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.symmetric(
                      horizontal: 4,
                      vertical: 9,
                    ),
                    child: Text(
                      options[i],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: isActive ? Colors.white : palette.textSec,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
