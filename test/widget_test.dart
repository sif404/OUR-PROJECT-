import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:axn_app/main.dart';
import 'package:axn_app/providers/theme_controller.dart';
import 'package:axn_app/theme/app_theme_data.dart';

void main() {
  testWidgets('AxnApp builds', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final controller = ThemeController.load();
    final loadedController = await controller;
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          themeControllerProvider.overrideWith((ref) => loadedController),
        ],
        child: AxnApp(themeController: loadedController),
      ),
    );
    await tester.pump();
    expect(tester.takeException(), isNull);
  });
}
