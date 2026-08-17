import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

class AppUser {
  final String uid;
  final String name;
  final String phoneNumber;

  const AppUser({
    required this.uid,
    required this.name,
    required this.phoneNumber,
  });

  String get initials {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || (parts.length == 1 && parts.first.isEmpty)) {
      return 'U';
    }
    if (parts.length == 1) {
      final s = parts.first;
      final len = s.length;
      return len <= 2 ? s.toUpperCase() : s.substring(0, 2).toUpperCase();
    }
    String firstChar(String s) => s.isEmpty ? '' : s.substring(0, 1);
    return '${firstChar(parts.first).toUpperCase()}${firstChar(parts.last).toUpperCase()}';
  }
}

final currentUserProvider = StreamProvider<AppUser?>((ref) async* {
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  await for (final User? fbUser in auth.authStateChanges()) {
    if (fbUser == null) {
      yield null;
      continue;
    }

    final uid = fbUser.uid;
    final docStream = firestore.collection('users').doc(uid).snapshots();

    await for (final snap in docStream) {
      final data = snap.data();
      final String fullName =
          (data?['fullName'] as String?)?.trim().isNotEmpty == true
              ? (data!['fullName'] as String).trim()
              : (fbUser.displayName?.trim().isNotEmpty == true
                  ? fbUser.displayName!.trim()
                  : 'User Name');
      final String mobile =
          (data?['mobile'] as String?)?.trim().isNotEmpty == true
              ? (data!['mobile'] as String).trim()
              : (fbUser.phoneNumber?.trim().isNotEmpty == true
                  ? fbUser.phoneNumber!.trim()
                  : '+962 7 9012 3456');

      yield AppUser(
        uid: uid,
        name: fullName,
        phoneNumber: mobile,
      );
    }
  }
});

Future<void> updateCurrentUserName(String newName) async {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) return;
  final trimmed = newName.trim();
  if (trimmed.isEmpty) return;
  await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .set(<String, dynamic>{'fullName': trimmed}, SetOptions(merge: true));
}

Future<void> updateCurrentUserHandle(String newHandle) async {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) return;
  final trimmed = newHandle.trim().replaceAll('@', '');
  if (trimmed.isEmpty) return;
  await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .set(<String, dynamic>{'handle': trimmed}, SetOptions(merge: true));
}
