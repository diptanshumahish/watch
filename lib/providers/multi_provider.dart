import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watch/providers/theme_provider.dart';
import 'package:watch/services/auth_service.dart';
import 'package:watch/services/shared_preference_service.dart';

final sharedPreferenceProvider = Provider<SharedPreferences>(
  (ref) => throw UnimplementedError(),
);

final localStorageAPIProvider = Provider<LocalStorageAPI>(
  (ref) => LocalStorageAPI(ref.watch(sharedPreferenceProvider)),
);

final themeProvider = ChangeNotifierProvider(
  (ref) => ThemeNotifier(),
);

final sessionStatusProvider = StreamProvider<User?>((ref) async* {
  yield* ref.watch(authAPIProvider.select((value) => value.user));
});

final firebaseAuthProvider = Provider<FirebaseAuth>(
  (ref) => FirebaseAuth.instance,
);

final authAPIProvider = Provider<AuthAPI>(
  (ref) => AuthAPI(ref.watch(firebaseAuthProvider)),
);
