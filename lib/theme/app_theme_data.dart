import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';
import 'app_dimens.dart';

enum AxnThemeMode { light, dark, system }

extension AxnThemeModeX on AxnThemeMode {
  String get storageKey {
    switch (this) {
      case AxnThemeMode.light:
        return 'light';
      case AxnThemeMode.dark:
        return 'dark';
      case AxnThemeMode.system:
        return 'system';
    }
  }

  static AxnThemeMode fromStorage(String? value) {
    switch (value) {
      case 'light':
        return AxnThemeMode.light;
      case 'dark':
        return AxnThemeMode.dark;
      case 'system':
      default:
        return AxnThemeMode.system;
    }
  }
}

class AppThemeData {
  AppThemeData._();

  static ThemeData light({bool isArabic = false}) {
    const scheme = ColorScheme.light(
      brightness: Brightness.light,
      primary: AppColors.brandRed,
      onPrimary: AppColors.white,
      primaryContainer: AppColors.emberTint,
      onPrimaryContainer: AppColors.emberDeep,
      secondary: Color(0xFF0FBFA7),
      onSecondary: AppColors.white,
      tertiary: AppColors.gold,
      onTertiary: AppColors.void_,
      surface: AppColors.white,
      onSurface: AppColors.void_,
      surfaceContainerHighest: AppColors.paper,
      error: AppColors.ember,
      onError: AppColors.white,
      outline: AppColors.stoneLine,
      outlineVariant: Color(0xFFEFE7D4),
    );
    return _build(
      scheme: scheme,
      isLight: true,
      isArabic: isArabic,
      bg: AppColors.white,
      surface: Color(0xFFFDFAF2),
      text: AppColors.void_,
      textMuted: AppColors.inkSoft,
      border: AppColors.stoneLine,
    );
  }

  static ThemeData dark({bool isArabic = false}) {
    const bgDark = Color(0xFF121212);
    const surfaceDark = Color(0xFF1A1A1A);
    const cardDark = Color(0xFF212121);

    const scheme = ColorScheme.dark(
      brightness: Brightness.dark,
      primary: Color(0xFFE63946),
      onPrimary: AppColors.white,
      primaryContainer: Color(0xFF3F1218),
      onPrimaryContainer: Color(0xFFFFD3D7),
      secondary: Color(0xFF0FBFA7),
      onSecondary: Color(0xFF003830),
      tertiary: AppColors.gold,
      onTertiary: AppColors.void_,
      surface: surfaceDark,
      onSurface: Color(0xFFF2F1EC),
      surfaceContainerHighest: cardDark,
      error: Color(0xFFE63946),
      onError: AppColors.white,
      outline: Color(0xFF3A3A3A),
      outlineVariant: Color(0xFF2E2E2E),
    );
    return _build(
      scheme: scheme,
      isLight: false,
      isArabic: isArabic,
      bg: bgDark,
      surface: surfaceDark,
      text: Color(0xFFF2F1EC),
      textMuted: Color(0xFFB6B2A8),
      border: Color(0xFF3A3A3A),
    );
  }

  static ThemeMode toThemeMode(AxnThemeMode m) {
    switch (m) {
      case AxnThemeMode.light:
        return ThemeMode.light;
      case AxnThemeMode.dark:
        return ThemeMode.dark;
      case AxnThemeMode.system:
        return ThemeMode.system;
    }
  }

  static ThemeData _build({
    required ColorScheme scheme,
    required bool isLight,
    required bool isArabic,
    required Color bg,
    required Color surface,
    required Color text,
    required Color textMuted,
    required Color border,
  }) {
    final headline = isArabic
        ? GoogleFonts.elMessiri(color: text)
        : GoogleFonts.playfairDisplay(color: text);
    final body = isArabic
        ? GoogleFonts.ibmPlexSansArabic(color: text)
        : GoogleFonts.inter(color: text);
    final mono = GoogleFonts.ibmPlexMono(color: text);
    final navLabel = isArabic
        ? GoogleFonts.ibmPlexSansArabic(color: text)
        : GoogleFonts.inter(color: text);
    final btnFont = isArabic
        ? GoogleFonts.elMessiri(fontSize: 15, fontWeight: FontWeight.w700)
        : GoogleFonts.playfairDisplay(fontSize: 15, fontWeight: FontWeight.w700);
    final tabLabel = isArabic
        ? GoogleFonts.elMessiri(fontSize: 14, fontWeight: FontWeight.w700)
        : GoogleFonts.playfairDisplay(fontSize: 14, fontWeight: FontWeight.w700);

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      brightness: scheme.brightness,
      scaffoldBackgroundColor: bg,
      canvasColor: bg,
      dividerColor: border,
      hintColor: textMuted,
      disabledColor: textMuted,
      visualDensity: VisualDensity.standard,
      fontFamily: body.fontFamily,
      textTheme: TextTheme(
        displayLarge: headline.copyWith(fontSize: 32, fontWeight: FontWeight.w800),
        displayMedium: headline.copyWith(fontSize: 28, fontWeight: FontWeight.w800),
        displaySmall: headline.copyWith(fontSize: 24, fontWeight: FontWeight.w800),
        headlineLarge: headline.copyWith(fontSize: 22, fontWeight: FontWeight.w800),
        headlineMedium: headline.copyWith(fontSize: 20, fontWeight: FontWeight.w700),
        headlineSmall: headline.copyWith(fontSize: 18, fontWeight: FontWeight.w700),
        titleLarge: headline.copyWith(fontSize: 16, fontWeight: FontWeight.w700),
        titleMedium: headline.copyWith(fontSize: 14.5, fontWeight: FontWeight.w600),
        titleSmall: headline.copyWith(fontSize: 13, fontWeight: FontWeight.w600),
        bodyLarge: body.copyWith(fontSize: 15),
        bodyMedium: body.copyWith(fontSize: 13.5),
        bodySmall: body.copyWith(fontSize: 12),
        labelLarge: body.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
        labelMedium: mono.copyWith(fontSize: 11, fontWeight: FontWeight.w600),
        labelSmall: mono.copyWith(fontSize: 10, fontWeight: FontWeight.w600),
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: bg,
        surfaceTintColor: Colors.transparent,
        foregroundColor: text,
        centerTitle: false,
        titleTextStyle: headline.copyWith(fontSize: 18, fontWeight: FontWeight.w700, color: text),
        systemOverlayStyle: isLight
            ? SystemUiOverlayStyle.dark.copyWith(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.dark,
                statusBarBrightness: Brightness.light,
                systemNavigationBarColor: bg,
                systemNavigationBarIconBrightness: Brightness.dark,
              )
            : SystemUiOverlayStyle.light.copyWith(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.light,
                statusBarBrightness: Brightness.dark,
                systemNavigationBarColor: bg,
                systemNavigationBarIconBrightness: Brightness.light,
              ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: surface,
        surfaceTintColor: Colors.transparent,
        indicatorColor: scheme.primary.withValues(alpha: 0.12),
        height: 64,
        labelTextStyle: WidgetStatePropertyAll(
          navLabel.copyWith(fontSize: 11, fontWeight: FontWeight.w600, color: text),
        ),
        iconTheme: WidgetStatePropertyAll(IconThemeData(color: textMuted, size: 22)),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: surface,
        selectedItemColor: scheme.primary,
        unselectedItemColor: textMuted,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedLabelStyle: navLabel.copyWith(fontSize: 11, fontWeight: FontWeight.w600),
        unselectedLabelStyle: navLabel.copyWith(fontSize: 11),
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: isLight ? AppDimens.cardElevation : 0,
        shadowColor: Colors.black.withValues(alpha: 0.06),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimens.cardRadius),
          side: isLight ? BorderSide.none : BorderSide(color: border, width: 1),
        ),
        surfaceTintColor: Colors.transparent,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          elevation: isLight ? 4 : 0,
          shadowColor: isLight ? scheme.primary.withValues(alpha: 0.35) : Colors.transparent,
          padding: const EdgeInsetsDirectional.symmetric(vertical: 14, horizontal: 20),
          textStyle: btnFont,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimens.btnRadius)),
          surfaceTintColor: Colors.transparent,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: scheme.primary,
          side: BorderSide(color: border, width: 1.2),
          padding: const EdgeInsetsDirectional.symmetric(vertical: 14, horizontal: 20),
          textStyle: btnFont,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimens.btnRadius)),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: scheme.primary,
          textStyle: tabLabel,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isLight ? const Color(0xFFFBF6EA) : const Color(0xFF1E1E1E),
        contentPadding: const EdgeInsetsDirectional.symmetric(horizontal: 14, vertical: 12),
        hintStyle: TextStyle(color: textMuted, fontSize: 13.5),
        labelStyle: TextStyle(color: textMuted, fontSize: 13),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimens.fieldRadius),
          borderSide: BorderSide(color: border, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimens.fieldRadius),
          borderSide: BorderSide(color: border, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimens.fieldRadius),
          borderSide: BorderSide(color: scheme.primary, width: 1.5),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: surface,
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
          side: BorderSide(color: Colors.transparent, width: 0),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: const Color(0xFF17130E),
        contentTextStyle: body.copyWith(color: AppColors.white, fontSize: 13),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      tabBarTheme: TabBarThemeData(
        labelColor: scheme.primary,
        unselectedLabelColor: textMuted,
        dividerColor: Colors.transparent,
        labelStyle: tabLabel,
        unselectedLabelStyle: tabLabel,
      ),
      listTileTheme: ListTileThemeData(
        textColor: text,
        iconColor: text,
      ),
      iconTheme: IconThemeData(color: text, size: 22),
      progressIndicatorTheme: ProgressIndicatorThemeData(color: scheme.primary),
      dividerTheme: DividerThemeData(color: border, thickness: 1, space: 1),
    );
  }

  static BoxDecoration cardDecoration(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isLight = Theme.of(context).brightness == Brightness.light;
    return BoxDecoration(
      color: scheme.surface,
      borderRadius: BorderRadius.circular(AppDimens.cardRadius),
      border: isLight ? null : Border.all(color: scheme.outlineVariant, width: 1),
      boxShadow: isLight
          ? [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ]
          : null,
    );
  }

  static Color statusBarColor(BuildContext context) => Colors.transparent;
}
