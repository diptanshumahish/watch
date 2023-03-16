import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../app/errors/errors.dart';
import 'auth_api_impl.dart';

final Provider<FirebaseAuth> firebaseAuthProvider = Provider<FirebaseAuth>(
  name: 'firebaseAuthProvider',
  (ProviderRef<FirebaseAuth> ref) => FirebaseAuth.instance,
);

final Provider<AuthAPI> authAPIProvider = Provider<AuthAPI>(
  name: 'authAPIProvider',
  (ProviderRef<AuthAPI> ref) => AuthAPI(ref.watch(firebaseAuthProvider)),
);

class AuthAPI implements AuthAPIImpl {
  AuthAPI(FirebaseAuth auth) : _auth = auth;

  late final FirebaseAuth _auth;

  ///Auth status change user stream
  @override
  Stream<User?> get user => _auth.authStateChanges();

  @override
  FutureEither<void> verifyResetPassword(String code) async {
    try {
      await _auth.verifyPasswordResetCode(code);
      return right(null);
    } on FirebaseAuthException catch (e) {
      return left(e.toFailure());
    } catch (e, stackTrace) {
      return left(
        Failure(message: 'Something went wrong', stackTrace: stackTrace),
      );
    }
  }

  @override
  FutureEither<void> resetPassword({
    required String email,
  }) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return right(null);
    } on FirebaseAuthException catch (e) {
      return left(e.toFailure());
    } catch (e, stackTrace) {
      return left(
        Failure(message: 'Something went wrong', stackTrace: stackTrace),
      );
    }
  }

  ///Signin user anonymously
  @override
  Future<SignInEither> signInAnonymously() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      return right(result);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'operation-not-allowed') {
        return left('Anonymous sign-in is not allowed');
      }
      return left('Something went wrong');
    } catch (e) {
      return left('Something went wrong');
    }
  }

  /// Sign in with email & password
  @override
  FutureEither<UserCredential> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return right(result);
    } on FirebaseAuthException catch (e) {
      return left(e.toFailure());
    } catch (e, stackTrace) {
      return left(
        Failure(message: 'Something went wrong', stackTrace: stackTrace),
      );
    }
  }

  ///Sign in user with Google returns [SignInEither] i.e. if
  ///the user is signed in successfully then it returns [UserCredential]else
  ///it returns [String] error message
  @override
  FutureEither<UserCredential> signInWithGoogle() async {
    try {
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      return right(await _auth.signInWithCredential(credential));
    } on FirebaseAuthException catch (e) {
      return left(e.toFailure());
    } catch (e) {
      return left(const Failure(message: 'Something went wrong'));
    }
  }

  ///Sign in with Facebook
  @override
  FutureEither<UserCredential> signInWithFacebook() async {
    try {
      LoginResult result = await FacebookAuth.instance.login();
      OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(result.accessToken!.token);
      return right(await _auth.signInWithCredential(facebookAuthCredential));
    } on FirebaseAuthException catch (e) {
      return left(e.toFailure());
    } catch (e) {
      return left(const Failure(message: 'Something went wrong'));
    }
  }

  ///Sign in user with apple
  @override
  FutureEither<UserCredential> signInWithApple() async {
    try {
      AppleAuthProvider appleProvider = AppleAuthProvider();
      if (!kIsWeb) {
        return right(await _auth.signInWithProvider(appleProvider));
      } else {
        return right(await _auth.signInWithPopup(appleProvider));
      }
    } on FirebaseAuthException catch (e) {
      return left(e.toFailure());
    } catch (e) {
      return left(const Failure(message: 'Something went wrong'));
    }
  }

  /// Sign up with email & password
  @override
  FutureEither<UserCredential> signUp(
      {required String email, required String password}) async {
    try {
      UserCredential user = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return right(user);
    } on FirebaseAuthException catch (e) {
      return left(e.toFailure());
    } catch (e) {
      log(e.toString(), name: 'AuthService', error: e);
      return left(const Failure(message: 'Something went wrong'));
    }
  }

  /// Sign out user and end the session
  /// Optional [futures] is a list of futures that will be executed before signing out
  @override
  Future<SignOutEither> signOut() async {
    try {
      await _auth.signOut();
      return right(unit);
    } catch (e) {
      return left(unit);
    }
  }
}
