import 'package:flutter/material.dart';
import 'i18n.dart';

/// Lightweight app-wide provider for [LocaleController], implemented with
/// plain [InheritedNotifier] so the project has zero state-management
/// dependencies beyond the SDK. Equivalent role to the global `currentLang`
/// variable + `toggleLang()` in the HTML prototype.
class AppScope extends InheritedNotifier<LocaleController> {
  const AppScope({
    super.key,
    required LocaleController controller,
    required super.child,
  }) : super(notifier: controller);

  static LocaleController of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppScope>();
    assert(scope != null, 'AppScope.of() called with no AppScope ancestor');
    return scope!.notifier!;
  }
}
