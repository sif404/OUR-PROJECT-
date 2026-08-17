import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

final groqApiKeyProvider = StateProvider<String>((ref) => '');

final themeProvider = StateProvider<String>((ref) => 'light');

class WeatherState {
  final String? temperature;
  final String? humidity;
  WeatherState({this.temperature, this.humidity});
}

final weatherProvider = FutureProvider<WeatherState>((ref) async {
  try {
    final dio = Dio();
    final response = await dio.get(
      'https://api.open-meteo.com/v1/forecast?latitude=31.9552&longitude=35.9284&current=temperature_2m,relative_humidity_2m',
    );
    if (response.statusCode == 200) {
      final current = response.data['current'];
      return WeatherState(
        temperature: current['temperature_2m']?.toString(),
        humidity: current['relative_humidity_2m']?.toString(),
      );
    }
  } catch (e) {
    // Ignore error, return empty
  }
  return WeatherState();
});
