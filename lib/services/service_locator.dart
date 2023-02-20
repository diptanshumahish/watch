import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watch/services/auth_service.dart';

import 'shared_preference_service.dart';

final getIt = GetIt.instance;

Future<void> initServiceLocator(SharedPreferences preferences) async {
  getIt.registerLazySingleton<PrefsService>(() => PrefsService(preferences));
  getIt.registerLazySingleton<AuthService>(
      () => AuthService(FirebaseAuth.instance));
}
