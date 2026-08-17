import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/app_theme_data.dart';

class ThemeController extends ChangeNotifier {
  ThemeController._(this._prefs, this._mode, this._languageCode);

  static const String _kKey = 'axn_theme_mode';
  static const String _kLang = 'axn_language_code';

  final SharedPreferences _prefs;
  AxnThemeMode _mode;
  String _languageCode;

  AxnThemeMode get mode => _mode;
  String get languageCode => _languageCode;

  ThemeMode get themeMode => AppThemeData.toThemeMode(_mode);

  static Future<ThemeController> load() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getString(_kKey);
    final mode = AxnThemeModeX.fromStorage(stored);
    // Default to LIGHT mode on first launch (even if system is dark).
    // Persist this choice immediately so it survives app restarts, and the
    // user can later override it manually from the Settings screen.
    if (stored == null) {
      await prefs.setString(_kKey, mode.storageKey);
    }

    String? storedLang = prefs.getString(_kLang);
    String langCode;
    if (storedLang != null) {
      langCode = storedLang;
    } else {
      final deviceLocale = PlatformDispatcher.instance.locale;
      final isDeviceArabic = deviceLocale.languageCode.toLowerCase() == 'ar';
      langCode = isDeviceArabic ? 'ar' : 'en';
      await prefs.setString(_kLang, langCode);
    }

    return ThemeController._(prefs, mode, langCode);
  }

  void setMode(AxnThemeMode mode) {
    if (mode == _mode) return;
    _mode = mode;
    _prefs.setString(_kKey, mode.storageKey);
    notifyListeners();
  }

  void setLanguage(String code) {
    if (code == _languageCode) return;
    _languageCode = code;
    _prefs.setString(_kLang, code);
    notifyListeners();
  }

  Brightness resolveBrightness(BuildContext context) {
    switch (_mode) {
      case AxnThemeMode.light:
        return Brightness.light;
      case AxnThemeMode.dark:
        return Brightness.dark;
      case AxnThemeMode.system:
        return MediaQuery.platformBrightnessOf(context);
    }
  }

  bool isDark(BuildContext context) => resolveBrightness(context) == Brightness.dark;
}

final themeControllerProvider = ChangeNotifierProvider<ThemeController>((ref) {
  throw UnimplementedError('Initialize themeControllerProvider via override in ProviderScope before runApp.');
});
