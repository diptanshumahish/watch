import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:watch/src/features/authentication/data/auth_api.dart';

import 'user_provider.dart';

final sessionStatusProvider = StreamProvider<User?>((ref) async* {
  Stream<User?> user = ref.watch(authAPIProvider.select((value) => value.user));
  ref.listenSelf((previous, next) {
    next.when(
      data: (user) {
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
      loading: () => log('Loading...'),
      error: (error, stack) => log('Error Encountered'),
    );
  });
  yield* user;
});
