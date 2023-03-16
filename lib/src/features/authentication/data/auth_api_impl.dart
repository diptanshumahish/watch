import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../app/errors/errors.dart';

typedef SignOutEither = Either<Unit, Unit>;
typedef SignInEither = Either<String, UserCredential>;

abstract class AuthAPIImpl {
  ///Auth status change user stream
  Stream<User?> get user;

  ///Signin user anonymously
  Future<SignInEither> signInAnonymously();

  /// Sign in with email & password
  FutureEither<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  FutureEither<void> resetPassword({required String email});

  FutureEither<void> verifyResetPassword(String code);

  ///Sign in user with Facebook returns [SignInEither]
  FutureEither<UserCredential> signInWithFacebook();

  ///Sign in user with Google returns [SignInEither]
  FutureEither<UserCredential> signInWithGoogle();

  ///Sign in user with Apple returns [SignInEither]
 FutureEither<UserCredential> signInWithApple();

  ///Sign up user with email & password
  FutureEither<UserCredential> signUp(
      {required String email, required String password});

  ///Sign out user
  Future<SignOutEither> signOut();
}
