import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../features/authentication/data/auth_api.dart';
import 'user_provider.dart';

final StreamProvider<User?> sessionStatusProvider = StreamProvider<User?>(
    name: 'sessionStatusProvider', (StreamProviderRef<User?> ref) async* {
  Stream<User?> user =
      ref.watch(authAPIProvider.select((AuthAPI value) => value.user));
  ref.listenSelf((AsyncValue<User?>? previous, AsyncValue<User?> next) {
    next.maybeWhen(
      data: (User? user) {
        if (user != null) {
          ref.read(userNotifierProvider.notifier).setUserProps(
                displayName: user.displayName,
                uid: user.uid,
                email: user.email,
              );
        } else {
          ref.read(userNotifierProvider.notifier).clearUser();
        }
      },
      orElse: () => log('Session status changed'),
    );
  });
  await Future<void>.delayed(const Duration(seconds: 2));
  yield* user;
});
