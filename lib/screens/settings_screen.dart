import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/theme_controller.dart';
import '../theme/app_theme_data.dart';
import '../models/app_scope.dart';

/// ============================================================
/// شاشة الإعدادات (Settings Screen) — نسخة مدموجة
/// ------------------------------------------------------------
/// الأساس: تصميم الملف الجديد (بحث + صندوق اقتراحات بدل "تواصل مع الدعم")
/// + وصل حقيقي بـ:
///   - ThemeController (Riverpod) => تبديل المظهر يغيّر التطبيق كله فعليًا
///   - AppScope => تبديل اللغة يغيّر لغة التطبيق كله فعليًا
///   - Callbacks حقيقية للتنقل (بدل TODO) تنمرّر من مكان استدعاء الشاشة
///
/// ملاحظة: النصوص محلية بقاموس _S داخل هذا الملف (بناءً على طلبك)،
/// مش عبر scope.t() — فقط تبديل اللغة نفسه متصل بالتطبيق.
/// ============================================================

enum AppLang { ar, en }

enum ThemePref { light, dark, system }

extension _ThemePrefX on ThemePref {
  AxnThemeMode toMode() {
    switch (this) {
      case ThemePref.light:
        return AxnThemeMode.light;
      case ThemePref.dark:
        return AxnThemeMode.dark;
      case ThemePref.system:
        return AxnThemeMode.system;
    }
  }

  static ThemePref fromMode(AxnThemeMode m) {
    switch (m) {
      case AxnThemeMode.light:
        return ThemePref.light;
      case AxnThemeMode.dark:
        return ThemePref.dark;
      case AxnThemeMode.system:
        return ThemePref.system;
    }
  }
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    super.key,
    this.onBack,
    this.onManageSafeZones,
    this.onChangePin,
    this.onHelpCenter,
    this.onReportProblem,
    this.onTermsOfService,
    this.onPrivacyPolicy,
  });

  /// زر الرجوع أعلى الشاشة.
  final VoidCallback? onBack;

  /// صف "إدارة المناطق الآمنة".
  final VoidCallback? onManageSafeZones;

  /// يُستدعى بعد ما المستخدم يدخل الرمز الحالي + الرمز الجديد ويضغط حفظ.
  /// هون المكان المناسب لاستدعاء Firebase Auth (updatePassword أو ما يعادله).
  final void Function(String currentPin, String newPin)? onChangePin;

  /// صف "مركز المساعدة".
  final VoidCallback? onHelpCenter;

  /// يُستدعى بعد ما المستخدم يكتب وصف المشكلة ويضغط إرسال.
  final void Function(String message)? onReportProblem;

  /// نص "شروط الاستخدام".
  final VoidCallback? onTermsOfService;

  /// نص "سياسة الخصوصية".
  final VoidCallback? onPrivacyPolicy;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // ---------------- الحالة (State) ----------------
  AppLang lang = AppLang.ar;
  ThemePref themePref = ThemePref.light;
  int fontStep = 1; // 0..3 -> صغير / افتراضي / كبير / أكبر
  String searchQuery = '';

  bool push = true;
  bool safeZoneAlerts = true;
  bool groupActivity = true;
  bool legacyCapsule = false;
  bool quietHours = false;
  bool shareLocation = true;
  bool biometric = true;
  bool cacheCleared = false;

  bool showSuggestionBox = false;
  final TextEditingController suggestionController = TextEditingController();

  bool showChangePinBox = false;
  final TextEditingController currentPinController = TextEditingController();
  final TextEditingController newPinController = TextEditingController();
  final TextEditingController confirmPinController = TextEditingController();

  bool showReportBox = false;
  final TextEditingController reportController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // مزامنة الحالة المحلية مع الثيم واللغة الحقيقيين للتطبيق عند فتح الشاشة.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final ctrl = ProviderScope.containerOf(context, listen: false)
          .read(themeControllerProvider);
      setState(() {
        themePref = _ThemePrefX.fromMode(ctrl.mode);
        lang = ctrl.languageCode == 'ar' ? AppLang.ar : AppLang.en;
      });
    });
  }

  @override
  void dispose() {
    suggestionController.dispose();
    currentPinController.dispose();
    newPinController.dispose();
    confirmPinController.dispose();
    reportController.dispose();
    super.dispose();
  }

  // ---------------- خطوات حجم الخط ----------------
  static const List<Map<String, double>> _fontSteps = [
    {'h': 20, 'title': 13, 'sub': 11.5},
    {'h': 22, 'title': 14.5, 'sub': 12.5},
    {'h': 24, 'title': 15.5, 'sub': 13.5},
    {'h': 26, 'title': 17, 'sub': 14.5},
  ];

  // ---------------- مساعدات عامة ----------------
  bool _resolveDark(BuildContext context) {
    if (themePref == ThemePref.system) {
      return MediaQuery.of(context).platformBrightness == Brightness.dark;
    }
    return themePref == ThemePref.dark;
  }

  void _showToast(String msg, _Palette c) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          msg,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: c.page,
            fontWeight: FontWeight.w600,
            fontSize: 12.5,
          ),
        ),
        backgroundColor: c.text,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(milliseconds: 1400),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        margin: const EdgeInsets.only(bottom: 24, left: 60, right: 60),
      ),
    );
  }

  /// تبديل المظهر — يحدّث الحالة المحلية وأيضًا الـ ThemeController الحقيقي
  /// (Riverpod)، فينعكس على التطبيق كله وليس هاي الشاشة بس.
  void _cycleTheme(_S t, _Palette c) {
    final next = switch (themePref) {
      ThemePref.light => ThemePref.dark,
      ThemePref.dark => ThemePref.system,
      ThemePref.system => ThemePref.light,
    };
    setState(() => themePref = next);
    final ctrl = ProviderScope.containerOf(context, listen: false)
        .read(themeControllerProvider);
    ctrl.setMode(next.toMode());
  }

  void _setTheme(ThemePref value) {
    setState(() => themePref = value);
    final ctrl = ProviderScope.containerOf(context, listen: false)
        .read(themeControllerProvider);
    ctrl.setMode(value.toMode());
  }

  /// تبديل اللغة — يحدّث الحالة المحلية وأيضًا ThemeController + AppScope
  /// الحقيقيين، فتتغيّر لغة التطبيق كله فعليًا (مو بس هاي الشاشة).
  void _setLang(AppLang value) {
    setState(() => lang = value);
    final code = value == AppLang.ar ? 'ar' : 'en';
    final ctrl = ProviderScope.containerOf(context, listen: false)
        .read(themeControllerProvider);
    ctrl.setLanguage(code);
    AppScope.of(context).setLang(code);
  }

  void _toggle(void Function(bool) setter, bool current, _S t, _Palette c) {
    HapticFeedback.selectionClick();
    setState(() => setter(!current));
    _showToast(t.toastSaved, c);
  }

  // ---------------- البناء (Build) ----------------
  @override
  Widget build(BuildContext context) {
    final bool dark = _resolveDark(context);
    final _Palette c = dark ? _Palette.dark() : _Palette.light();
    final _S t = lang == AppLang.ar ? _S.ar() : _S.en();
    final TextDirection dir =
        lang == AppLang.ar ? TextDirection.rtl : TextDirection.ltr;
    final fs = _fontSteps[fontStep];
    final headFont = GoogleFonts.playfairDisplay();

    final sections = _buildSections(t, c, fs, dir, headFont);

    final query = searchQuery.trim().toLowerCase();
    final visible = query.isEmpty
        ? sections
        : sections.where((s) => s.searchText.contains(query)).toList();

    return Directionality(
      textDirection: dir,
      child: Scaffold(
        backgroundColor: c.page,
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(18, 12, 18, 26),
            children: [
              // ---------- Topbar ----------
              Row(
                children: [
                  _circleButton(
                    c,
                    icon: dir == TextDirection.rtl
                        ? Icons.chevron_right
                        : Icons.chevron_left,
                    onTap: widget.onBack ?? () => Navigator.of(context).maybePop(),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      t.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: headFont.copyWith(
                        fontSize: fs['h'],
                        fontWeight: FontWeight.w700,
                        color: c.text,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  _circleButton(
                    c,
                    icon: switch (themePref) {
                      ThemePref.light => Icons.light_mode_outlined,
                      ThemePref.dark => Icons.dark_mode_outlined,
                      ThemePref.system => Icons.brightness_auto_outlined,
                    },
                    onTap: () => _cycleTheme(t, c),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // ---------- شريط البحث ----------
              Container(
                height: 40,
                decoration: BoxDecoration(
                  color: c.card,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: c.border),
                ),
                child: TextField(
                  onChanged: (v) => setState(() => searchQuery = v),
                  style: TextStyle(fontSize: 13, color: c.text),
                  textAlign:
                      dir == TextDirection.rtl ? TextAlign.right : TextAlign.left,
                  decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    hintText: t.searchPh,
                    hintStyle: TextStyle(color: c.textMut, fontSize: 13),
                    prefixIcon: dir == TextDirection.rtl
                        ? null
                        : Icon(Icons.search, size: 18, color: c.textMut),
                    suffixIcon: dir == TextDirection.rtl
                        ? Icon(Icons.search, size: 18, color: c.textMut)
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: 18),

              // ---------- الأقسام (مفلترة بالبحث) ----------
              if (visible.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Text(
                    t.noResults,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: c.textMut, fontSize: 13),
                  ),
                )
              else
                ...visible.map((s) => s.widget),

              const SizedBox(height: 22),

              // ---------- Footer ----------
              Column(
                children: [
                  Text(
                    t.version,
                    style: TextStyle(fontSize: 11.5, color: c.textMut),
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () => _showToast(t.toastRate, c),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.star_border, size: 14, color: c.accent),
                          const SizedBox(width: 6),
                          Text(
                            t.rate,
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w700,
                              color: c.accent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------- بناء الأقسام ----------------
  List<_SectionData> _buildSections(_S t, _Palette c, Map<String, double> fs,
      TextDirection dir, TextStyle headFont) {
    return [
      _SectionData(
        searchText: '${t.notifications} ${t.pushT} ${t.pushS} ${t.szT} '
                '${t.szS} ${t.gaT} ${t.gaS} ${t.lcT} ${t.lcS} ${t.quietT} '
                '${t.quietS} ${t.manageSz}'
            .toLowerCase(),
        widget: _block(
          c,
          fs,
          headFont,
          label: t.notifications,
          isFirst: true,
          children: [
            _row(c, fs, headFont,
                icon: Icons.notifications_outlined,
                title: t.pushT,
                sub: t.pushS,
                trailing: _switch(c, push, (v) => _toggle((x) => push = x, push, t, c))),
            _row(c, fs, headFont,
                icon: Icons.shield_outlined,
                title: t.szT,
                sub: t.szS,
                trailing: _switch(c, safeZoneAlerts,
                    (v) => _toggle((x) => safeZoneAlerts = x, safeZoneAlerts, t, c))),
            _row(c, fs, headFont,
                icon: Icons.groups_outlined,
                title: t.gaT,
                sub: t.gaS,
                trailing: _switch(c, groupActivity,
                    (v) => _toggle((x) => groupActivity = x, groupActivity, t, c))),
            _row(c, fs, headFont,
                icon: Icons.archive_outlined,
                title: t.lcT,
                sub: t.lcS,
                trailing: _switch(c, legacyCapsule,
                    (v) => _toggle((x) => legacyCapsule = x, legacyCapsule, t, c))),
            _row(c, fs, headFont,
                icon: Icons.nightlight_outlined,
                title: t.quietT,
                sub: t.quietS,
                trailing: _switch(c, quietHours,
                    (v) => _toggle((x) => quietHours = x, quietHours, t, c))),
            _linkRow(c, fs,
                icon: Icons.location_on_outlined,
                title: t.manageSz,
                dir: dir,
                isLast: true,
                onTap: widget.onManageSafeZones),
          ],
        ),
      ),
      _SectionData(
        searchText: '${t.preferences} ${t.lang} ${t.theme}'.toLowerCase(),
        widget: _block(
          c,
          fs,
          headFont,
          label: t.preferences,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
              child: Row(
                children: [
                  Icon(Icons.language_outlined, size: 18, color: c.accent),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(t.lang,
                        style: headFont.copyWith(
                            fontSize: fs['title'],
                            fontWeight: FontWeight.w600,
                            color: c.text)),
                  ),
                  SizedBox(
                    width: 120,
                    child: _segmented(
                      c,
                      options: t.langOpts,
                      activeIndex: lang == AppLang.ar ? 1 : 0,
                      onSelect: (i) => _setLang(i == 1 ? AppLang.ar : AppLang.en),
                    ),
                  ),
                ],
              ),
            ),
            Container(height: 1, color: c.border),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Icon(
                        switch (themePref) {
                          ThemePref.light => Icons.light_mode_outlined,
                          ThemePref.dark => Icons.dark_mode_outlined,
                          ThemePref.system => Icons.brightness_auto_outlined,
                        },
                        size: 18,
                        color: c.accent,
                      ),
                      const SizedBox(width: 12),
                      Text(t.theme,
                          style: headFont.copyWith(
                              fontSize: fs['title'],
                              fontWeight: FontWeight.w600,
                              color: c.text)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  _segmented(
                    c,
                    options: t.themeOpts,
                    activeIndex: ThemePref.values.indexOf(themePref),
                    onSelect: (i) => _setTheme(ThemePref.values[i]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      _SectionData(
        searchText: '${t.accessibility} ${t.fontSize}'.toLowerCase(),
        widget: _block(
          c,
          fs,
          headFont,
          label: t.accessibility,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Icon(Icons.text_fields_outlined, size: 18, color: c.accent),
                      const SizedBox(width: 12),
                      Text(t.fontSize,
                          style: headFont.copyWith(
                              fontSize: fs['title'],
                              fontWeight: FontWeight.w600,
                              color: c.text)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  _segmented(
                    c,
                    options: t.fontOpts,
                    activeIndex: fontStep,
                    onSelect: (i) => setState(() => fontStep = i),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      _SectionData(
        searchText: '${t.location} ${t.shareT} ${t.shareS}'.toLowerCase(),
        widget: _block(
          c,
          fs,
          headFont,
          label: t.location,
          children: [
            _row(c, fs, headFont,
                icon: Icons.location_on_outlined,
                title: t.shareT,
                sub: t.shareS,
                isLast: true,
                trailing: _switch(c, shareLocation,
                    (v) => _toggle((x) => shareLocation = x, shareLocation, t, c))),
          ],
        ),
      ),
      _SectionData(
        searchText: '${t.account} ${t.pin} ${t.bioT} ${t.bioS}'.toLowerCase(),
        widget: _block(
          c,
          fs,
          headFont,
          label: t.account,
          children: [
            _linkRow(c, fs,
                icon: Icons.lock_outline,
                title: t.pin,
                dir: dir,
                onTap: () => setState(() => showChangePinBox = !showChangePinBox)),
            AnimatedCrossFade(
              duration: const Duration(milliseconds: 200),
              crossFadeState: showChangePinBox
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              firstChild: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 14),
                color: c.card,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _pinField(c, fs, currentPinController, t.pinCurrentHint),
                    const SizedBox(height: 8),
                    _pinField(c, fs, newPinController, t.pinNewHint),
                    const SizedBox(height: 8),
                    _pinField(c, fs, confirmPinController, t.pinConfirmHint),
                    const SizedBox(height: 10),
                    Align(
                      alignment: dir == TextDirection.rtl
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: c.accent,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 10),
                        ),
                        onPressed: () {
                          final current = currentPinController.text.trim();
                          final newPin = newPinController.text.trim();
                          final confirm = confirmPinController.text.trim();
                          if (current.isEmpty || newPin.isEmpty || confirm.isEmpty) {
                            _showToast(t.pinFillAll, c);
                            return;
                          }
                          if (newPin != confirm) {
                            _showToast(t.pinMismatch, c);
                            return;
                          }
                          widget.onChangePin?.call(current, newPin);
                          currentPinController.clear();
                          newPinController.clear();
                          confirmPinController.clear();
                          setState(() => showChangePinBox = false);
                          _showToast(t.toastPinChanged, c);
                        },
                        child: Text(
                          t.pinSave,
                          style: const TextStyle(
                              fontSize: 12.5, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              secondChild: const SizedBox.shrink(),
            ),
            _row(c, fs, headFont,
                icon: Icons.fingerprint,
                title: t.bioT,
                sub: t.bioS,
                isLast: true,
                trailing: _switch(c, biometric,
                    (v) => _toggle((x) => biometric = x, biometric, t, c))),
          ],
        ),
      ),
      _SectionData(
        searchText: '${t.storage} ${t.cacheT} ${t.exportT} ${t.exportS}'
            .toLowerCase(),
        widget: _block(
          c,
          fs,
          headFont,
          label: t.storage,
          children: [
            _linkRow(c, fs,
                icon: Icons.delete_outline,
                title: t.cacheT,
                dir: dir,
                meta: cacheCleared
                    ? '0 ${lang == AppLang.ar ? "ك.ب" : "KB"}'
                    : t.cacheSize,
                onTap: () {
                  setState(() => cacheCleared = true);
                  _showToast(t.toastCache, c);
                }),
            _row(c, fs, headFont,
                icon: Icons.download_outlined,
                title: t.exportT,
                sub: t.exportS,
                isLast: true,
                trailing: InkWell(
                  onTap: () => _showToast(t.toastExport, c),
                  child: Icon(
                    dir == TextDirection.rtl
                        ? Icons.chevron_left
                        : Icons.chevron_right,
                    color: c.textMut,
                  ),
                )),
          ],
        ),
      ),
      // ---------- المساعدة والدعم (بدون تواصل مع الدعم، مع صندوق الاقتراحات) ----------
      _SectionData(
        searchText:
            '${t.help} ${t.helpCenter} ${t.report} ${t.terms} ${t.privacy} '
                    '${t.suggestionsTitle} ${t.suggestionsHint}'
                .toLowerCase(),
        widget: _block(
          c,
          fs,
          headFont,
          label: t.help,
          children: [
            _linkRow(c, fs,
                icon: Icons.help_outline,
                title: t.helpCenter,
                dir: dir,
                onTap: widget.onHelpCenter),
            _linkRow(c, fs,
                icon: Icons.chat_bubble_outline,
                title: t.suggestionsTitle,
                dir: dir,
                onTap: () =>
                    setState(() => showSuggestionBox = !showSuggestionBox)),
            AnimatedCrossFade(
              duration: const Duration(milliseconds: 200),
              crossFadeState: showSuggestionBox
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              firstChild: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 14),
                color: c.card,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      controller: suggestionController,
                      maxLines: 4,
                      style: TextStyle(fontSize: fs['sub']! + 1, color: c.text),
                      decoration: InputDecoration(
                        hintText: t.suggestionsHint,
                        hintStyle: TextStyle(color: c.textMut, fontSize: 12.5),
                        filled: true,
                        fillColor: c.page,
                        contentPadding: const EdgeInsets.all(12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: c.border),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: c.border),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: c.accent),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: dir == TextDirection.rtl
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: c.accent,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 10),
                        ),
                        onPressed: () {
                          if (suggestionController.text.trim().isEmpty) return;
                          suggestionController.clear();
                          setState(() => showSuggestionBox = false);
                          _showToast(t.toastSuggestionSent, c);
                        },
                        child: Text(
                          t.suggestionsSend,
                          style: const TextStyle(
                              fontSize: 12.5, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              secondChild: const SizedBox.shrink(),
            ),
            _linkRow(c, fs,
                icon: Icons.flag_outlined,
                title: t.report,
                dir: dir,
                onTap: () => setState(() => showReportBox = !showReportBox)),
            AnimatedCrossFade(
              duration: const Duration(milliseconds: 200),
              crossFadeState: showReportBox
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              firstChild: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 14),
                color: c.card,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      controller: reportController,
                      maxLines: 4,
                      style: TextStyle(fontSize: fs['sub']! + 1, color: c.text),
                      decoration: InputDecoration(
                        hintText: t.reportHint,
                        hintStyle: TextStyle(color: c.textMut, fontSize: 12.5),
                        filled: true,
                        fillColor: c.page,
                        contentPadding: const EdgeInsets.all(12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: c.border),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: c.border),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: c.accent),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: dir == TextDirection.rtl
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: c.accent,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 10),
                        ),
                        onPressed: () {
                          final msg = reportController.text.trim();
                          if (msg.isEmpty) return;
                          widget.onReportProblem?.call(msg);
                          reportController.clear();
                          setState(() => showReportBox = false);
                          _showToast(t.toastReportSent, c);
                        },
                        child: Text(
                          t.suggestionsSend,
                          style: const TextStyle(
                              fontSize: 12.5, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              secondChild: const SizedBox.shrink(),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
              child: Row(
                children: [
                  InkWell(
                    onTap: widget.onTermsOfService,
                    child: Text(t.terms,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: c.textMut)),
                  ),
                  const SizedBox(width: 20),
                  InkWell(
                    onTap: widget.onPrivacyPolicy,
                    child: Text(t.privacy,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: c.textMut)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ];
  }

  // ---------------- عناصر واجهة قابلة لإعادة الاستخدام ----------------

  Widget _circleButton(_Palette c,
      {required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(color: c.card, shape: BoxShape.circle),
        child: Icon(icon, size: 18, color: c.text),
      ),
    );
  }

  Widget _block(_Palette c, Map<String, double> fs, TextStyle headFont,
      {required String label,
      required List<Widget> children,
      bool isFirst = false}) {
    return Padding(
      padding: EdgeInsets.only(top: isFirst ? 0 : 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(2, 0, 2, 8),
            child: Text(
              label,
              style: TextStyle(
                fontSize: fs['sub'],
                fontWeight: FontWeight.w700,
                color: c.accent,
                letterSpacing: .4,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: c.card,
              borderRadius: BorderRadius.circular(16),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch, children: children),
          ),
        ],
      ),
    );
  }

  Widget _row(_Palette c, Map<String, double> fs, TextStyle headFont,
      {required IconData icon,
      required String title,
      String? sub,
      required Widget trailing,
      bool isLast = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : Border(bottom: BorderSide(color: c.border, width: 1)),
      ),
      child: Row(
        children: [
          _iconBadge(c, icon),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: headFont.copyWith(
                        fontSize: fs['title'],
                        fontWeight: FontWeight.w600,
                        color: c.text)),
                if (sub != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 3),
                    child: Text(sub,
                        style: TextStyle(fontSize: fs['sub'], color: c.textSec, height: 1.35)),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          trailing,
        ],
      ),
    );
  }

  Widget _linkRow(_Palette c, Map<String, double> fs,
      {required IconData icon,
      required String title,
      required TextDirection dir,
      String? meta,
      VoidCallback? onTap,
      bool isLast = false}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: isLast
              ? null
              : Border(bottom: BorderSide(color: c.border, width: 1)),
        ),
        child: Row(
          children: [
            _iconBadge(c, icon),
            const SizedBox(width: 12),
            Expanded(
              child: Text(title,
                  style: TextStyle(
                      fontSize: fs['title'],
                      fontWeight: FontWeight.w600,
                      color: c.text)),
            ),
            if (meta != null)
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Text(meta,
                    style: TextStyle(
                        fontSize: fs['sub'], color: c.textMut, fontWeight: FontWeight.w600)),
              ),
            Icon(
              dir == TextDirection.rtl
                  ? Icons.chevron_left
                  : Icons.chevron_right,
              size: 18,
              color: c.textMut,
            ),
          ],
        ),
      ),
    );
  }

  Widget _iconBadge(_Palette c, IconData icon) {
    return Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        color: c.accentTint,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, size: 18, color: c.accent),
    );
  }

  Widget _pinField(_Palette c, Map<String, double> fs,
      TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      obscureText: true,
      keyboardType: TextInputType.number,
      maxLength: 6,
      style: TextStyle(fontSize: fs['sub']! + 1, color: c.text),
      decoration: InputDecoration(
        counterText: '',
        hintText: hint,
        hintStyle: TextStyle(color: c.textMut, fontSize: 12.5),
        filled: true,
        fillColor: c.page,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: c.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: c.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: c.accent),
        ),
      ),
    );
  }

  Widget _switch(_Palette c, bool value, ValueChanged<bool> onChanged) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: 44,
        height: 26,
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: value ? c.accent : c.trackOff,
          borderRadius: BorderRadius.circular(20),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 180),
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 20,
            height: 20,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: Colors.black26, blurRadius: 2, offset: Offset(0, 1)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _segmented(_Palette c,
      {required List<String> options,
      required int activeIndex,
      required ValueChanged<int> onSelect}) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: c.cardAlt,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: List.generate(options.length, (i) {
          final active = i == activeIndex;
          return Expanded(
            child: GestureDetector(
              onTap: () => onSelect(i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.symmetric(horizontal: 1),
                padding: const EdgeInsets.symmetric(vertical: 9),
                decoration: BoxDecoration(
                  color: active ? c.accent : Colors.transparent,
                  borderRadius: BorderRadius.circular(9),
                ),
                alignment: Alignment.center,
                child: Text(
                  options[i],
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                    color: active ? Colors.white : c.textSec,
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

// ================= بيانات مساعدة =================

class _SectionData {
  final String searchText;
  final Widget widget;
  _SectionData({required this.searchText, required this.widget});
}

/// لوحة الألوان (Light/Dark) - مطابقة لمتغيرات CSS الأصلية
class _Palette {
  final Color page, card, cardAlt, text, textSec, textMut, border, accent,
      accentStrong, accentTint, trackOff, success, danger;

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
    required this.success,
    required this.danger,
  });

  factory _Palette.light() => const _Palette(
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
        success: Color(0xFF1E8E5A),
        danger: Color(0xFFCE1126),
      );

  factory _Palette.dark() => const _Palette(
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
        success: Color(0xFF34C185),
        danger: Color(0xFFE31B33),
      );
}

/// النصوص (عربي/إنجليزي) - قاموس محلي (بناءً على طلبك: أسهل وأسرع)
class _S {
  final String title,
      searchPh,
      noResults,
      notifications,
      pushT,
      pushS,
      szT,
      szS,
      gaT,
      gaS,
      lcT,
      lcS,
      quietT,
      quietS,
      manageSz,
      preferences,
      lang,
      theme,
      accessibility,
      fontSize,
      location,
      shareT,
      shareS,
      account,
      pin,
      bioT,
      bioS,
      storage,
      cacheT,
      cacheSize,
      exportT,
      exportS,
      help,
      helpCenter,
      report,
      terms,
      privacy,
      rate,
      version,
      toastSaved,
      toastCache,
      toastExport,
      toastRate,
      suggestionsTitle,
      suggestionsHint,
      suggestionsSend,
      toastSuggestionSent,
      pinCurrentHint,
      pinNewHint,
      pinConfirmHint,
      pinSave,
      pinFillAll,
      pinMismatch,
      toastPinChanged,
      reportHint,
      toastReportSent;
  final List<String> langOpts, themeOpts, fontOpts;

  const _S({
    required this.title,
    required this.searchPh,
    required this.noResults,
    required this.notifications,
    required this.pushT,
    required this.pushS,
    required this.szT,
    required this.szS,
    required this.gaT,
    required this.gaS,
    required this.lcT,
    required this.lcS,
    required this.quietT,
    required this.quietS,
    required this.manageSz,
    required this.preferences,
    required this.lang,
    required this.langOpts,
    required this.theme,
    required this.themeOpts,
    required this.accessibility,
    required this.fontSize,
    required this.fontOpts,
    required this.location,
    required this.shareT,
    required this.shareS,
    required this.account,
    required this.pin,
    required this.bioT,
    required this.bioS,
    required this.storage,
    required this.cacheT,
    required this.cacheSize,
    required this.exportT,
    required this.exportS,
    required this.help,
    required this.helpCenter,
    required this.report,
    required this.terms,
    required this.privacy,
    required this.rate,
    required this.version,
    required this.toastSaved,
    required this.toastCache,
    required this.toastExport,
    required this.toastRate,
    required this.suggestionsTitle,
    required this.suggestionsHint,
    required this.suggestionsSend,
    required this.toastSuggestionSent,
    required this.pinCurrentHint,
    required this.pinNewHint,
    required this.pinConfirmHint,
    required this.pinSave,
    required this.pinFillAll,
    required this.pinMismatch,
    required this.toastPinChanged,
    required this.reportHint,
    required this.toastReportSent,
  });

  factory _S.ar() => const _S(
        title: 'الإعدادات',
        searchPh: 'ابحث في الإعدادات...',
        noResults: 'ما في نتائج مطابقة',
        notifications: 'التنبيهات',
        pushT: 'إشعارات فورية',
        pushS: 'تنبيهات عامة من التطبيق',
        szT: 'تنبيهات المناطق الآمنة',
        szS: 'إشعار عند الدخول أو الخروج من منطقة آمنة',
        gaT: 'نشاط المجموعة',
        gaS: 'تحديثات عن نشاط أفراد المجموعة',
        lcT: 'تنبيهات الكبسولة القديمة',
        lcS: 'إشعارات متعلقة بالميزات القديمة',
        quietT: 'ساعات الهدوء',
        quietS: 'كتم الإشعارات من 10 مساءً حتى 7 صباحًا',
        manageSz: 'إدارة المناطق الآمنة',
        preferences: 'التفضيلات',
        lang: 'اللغة',
        langOpts: ['EN', 'AR'],
        theme: 'المظهر',
        themeOpts: ['فاتح', 'داكن', 'تلقائي'],
        accessibility: 'إمكانية الوصول',
        fontSize: 'حجم الخط',
        fontOpts: ['صغير', 'افتراضي', 'كبير', 'أكبر'],
        location: 'الموقع والمشاركة',
        shareT: 'مشاركة الموقع المباشر',
        shareS: 'يشوفوا موقعك أفراد مجموعتك بشكل لحظي',
        account: 'الحساب والأمان',
        pin: 'تغيير الرمز السري',
        bioT: 'فتح ببصمة/بصمة الوجه',
        bioS: 'استخدم البصمة بدل الرمز السري',
        storage: 'التخزين والبيانات',
        cacheT: 'مسح الذاكرة المؤقتة',
        cacheSize: '24 م.ب',
        exportT: 'تنزيل نسخة من بياناتي',
        exportS: 'ملف يشمل معلوماتك وسجل نشاطك',
        help: 'المساعدة والدعم',
        helpCenter: 'مركز المساعدة',
        report: 'الإبلاغ عن مشكلة',
        terms: 'شروط الاستخدام',
        privacy: 'سياسة الخصوصية',
        rate: 'قيّم التطبيق',
        version: 'الإصدار 2.4.1 (120)',
        toastSaved: 'تم الحفظ',
        toastCache: 'تم مسح الذاكرة المؤقتة',
        toastExport: 'جاري تجهيز ملف بياناتك...',
        toastRate: 'شكرًا لتقييمك!',
        suggestionsTitle: 'الاقتراحات والشكاوي',
        suggestionsHint: 'اكتب اقتراحك أو شكواك هون...',
        suggestionsSend: 'إرسال',
        toastSuggestionSent: 'تم إرسال ملاحظاتك، شكرًا!',
        pinCurrentHint: 'الرمز السري الحالي',
        pinNewHint: 'الرمز السري الجديد',
        pinConfirmHint: 'تأكيد الرمز الجديد',
        pinSave: 'حفظ',
        pinFillAll: 'الرجاء تعبئة كل الحقول',
        pinMismatch: 'الرمز الجديد وتأكيده غير متطابقين',
        toastPinChanged: 'تم تغيير الرمز السري',
        reportHint: 'اكتب وصف المشكلة هون...',
        toastReportSent: 'تم إرسال بلاغك، شكرًا!',
      );

  factory _S.en() => const _S(
        title: 'Settings',
        searchPh: 'Search settings...',
        noResults: 'No matching results',
        notifications: 'Notifications',
        pushT: 'Push notifications',
        pushS: 'General alerts from the app',
        szT: 'Safe zone alerts',
        szS: 'Get notified entering or leaving a safe zone',
        gaT: 'Group activity',
        gaS: "Updates about your group members' activity",
        lcT: 'Legacy capsule alerts',
        lcS: 'Notifications for legacy features',
        quietT: 'Quiet hours',
        quietS: 'Mute notifications from 10 PM to 7 AM',
        manageSz: 'Manage safe zones',
        preferences: 'Preferences',
        lang: 'Language',
        langOpts: ['EN', 'AR'],
        theme: 'Theme',
        themeOpts: ['Light', 'Dark', 'System'],
        accessibility: 'Accessibility',
        fontSize: 'Font size',
        fontOpts: ['Small', 'Default', 'Large', 'X-Large'],
        location: 'Location & sharing',
        shareT: 'Share live location',
        shareS: 'Group members can see your live location',
        account: 'Account & security',
        pin: 'Change PIN',
        bioT: 'Biometric unlock',
        bioS: 'Use Face/Touch ID instead of PIN',
        storage: 'Data & storage',
        cacheT: 'Clear cache',
        cacheSize: '24 MB',
        exportT: 'Download my data',
        exportS: 'A file with your info and activity log',
        help: 'Help & support',
        helpCenter: 'Help center',
        report: 'Report a problem',
        terms: 'Terms of service',
        privacy: 'Privacy policy',
        rate: 'Rate the app',
        version: 'Version 2.4.1 (120)',
        toastSaved: 'Saved',
        toastCache: 'Cache cleared',
        toastExport: 'Preparing your data export...',
        toastRate: 'Thanks for rating!',
        suggestionsTitle: 'Suggestions & complaints',
        suggestionsHint: 'Write your suggestion or complaint here...',
        suggestionsSend: 'Send',
        toastSuggestionSent: 'Your feedback was sent, thank you!',
        pinCurrentHint: 'Current PIN',
        pinNewHint: 'New PIN',
        pinConfirmHint: 'Confirm new PIN',
        pinSave: 'Save',
        pinFillAll: 'Please fill in all fields',
        pinMismatch: 'New PIN and confirmation do not match',
        toastPinChanged: 'PIN changed',
        reportHint: 'Describe the problem here...',
        toastReportSent: 'Your report was sent, thank you!',
      );
}