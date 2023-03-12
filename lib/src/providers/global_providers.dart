import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:watch/src/features/authentication/data/auth_api.dart';

final sessionStatusProvider = StreamProvider<User?>((ref) async* {
  yield* ref.watch(authAPIProvider.select((value) => value.user));
});




