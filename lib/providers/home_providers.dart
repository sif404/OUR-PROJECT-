import 'package:flutter_riverpod/flutter_riverpod.dart';

final groqApiKeyProvider = StateProvider<String>((ref) => '');

final themeProvider = StateProvider<String>((ref) => 'light');
