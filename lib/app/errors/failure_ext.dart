import 'dart:io';

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

extension HttpExt on HttpException {
  ///Converts [HttpException] to [Failure] object
  Failure toFailure(StackTrace? stackTrace) => Failure(
        message: message,
        stackTrace: stackTrace,
      );
}

extension IoExt on IOException {
  ///Converts [IOException] to [Failure] object
  Failure toFailure() => const Failure(
        message: 'IO Exception',
      );
}

extension FormatExt on FormatException {
  ///Converts [FormatException] to [Failure] object
  Failure toFailure() => Failure(message: message);
}
