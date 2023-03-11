import 'package:firebase_auth/firebase_auth.dart';

import 'failure.dart';

extension FailureExt on FirebaseAuthException {
  ///Converts [FirebaseAuthException] to [Failure] object
  Failure toFailure() => Failure(
        message: message ?? 'Unknown error',
        code: code,
        stackTrace: stackTrace,
      );
}
