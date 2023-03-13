import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:watch/app/errors/errors.dart';

import 'auth_api_impl.dart';

final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final authAPIProvider = Provider<AuthAPI>(
  (ref) => AuthAPI(ref.watch(firebaseAuthProvider)),
);

class AuthAPI implements AuthAPIImpl {
  AuthAPI(FirebaseAuth auth) : _auth = auth;

  late final FirebaseAuth _auth;

  ///Auth status change user stream
  @override
  Stream<User?> get user => _auth.authStateChanges();

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
  Future<SignInEither> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      return right(await _auth.signInWithCredential(credential));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        return left('The account already exists with a different credential.');
      } else if (e.code == 'invalid-credential') {
        return left('Error occurred while accessing credentials. Try again.');
      } else if (e.code == 'operation-not-allowed') {
        return left('Unable to sign in with Google.');
      } else if (e.code == 'user-disabled') {
        return left('The user account has been disabled by an administrator.');
      } else if (e.code == 'user-not-found') {
        return left('No user found for these credentials');
      } else if (e.code == 'wrong-password') {
        return left('Wrong password provided for the user');
      } else if (e.code == 'invalid-verification-code') {
        return left('The verification code is invalid.');
      }
      return left('The verification ID is invalid.');
    } catch (e) {
      log(e.toString(), name: 'AuthService.signInWithGoogle', error: e);
      return left('Something went wrong');
    }
  }

  ///Sign in with Facebook
  @override
  Future<SignInEither> signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(result.accessToken!.token);
      return right(await _auth.signInWithCredential(facebookAuthCredential));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        return left('The account already exists with a different credential.');
      } else if (e.code == 'invalid-credential') {
        return left('Error occurred while accessing credentials. Try again.');
      } else if (e.code == 'operation-not-allowed') {
        return left('Unable to sign in with Facebook.');
      } else if (e.code == 'user-disabled') {
        return left('The user account has been disabled by an administrator.');
      } else if (e.code == 'user-not-found') {
        return left('No user found for these credentials');
      } else if (e.code == 'wrong-password') {
        return left('Wrong password provided for the user');
      } else if (e.code == 'invalid-verification-code') {
        return left('Invalid verification code');
      }
      return left('Inavlid verification ID');
    } catch (e) {
      log(e.toString(), name: 'AuthService.signInWithFacebook', error: e);
      return left('Something went wrong');
    }
  }

  ///Sign in user with apple
  @override
  Future<SignInEither> signInWithApple() async {
    try {
      AppleAuthProvider appleProvider = AppleAuthProvider();
      if (!kIsWeb) {
        return right(await _auth.signInWithProvider(appleProvider));
      } else {
        return right(await _auth.signInWithPopup(appleProvider));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        return left('The account already exists with a different credential.');
      } else if (e.code == 'invalid-credential') {
        return left('Error occurred while accessing credentials. Try again.');
      } else if (e.code == 'operation-not-allowed') {
        return left('Unable to sign in with Apple.');
      } else if (e.code == 'user-disabled') {
        return left('The user account has been disabled by an administrator.');
      } else if (e.code == 'user-not-found') {
        return left('No user found for these credentials');
      } else if (e.code == 'wrong-password') {
        return left('Wrong password provided for the user');
      } else if (e.code == 'invalid-verification-code') {
        return left('Invalid verification code');
      }
      return left('Inavlid verification ID');
    } catch (e) {
      log(e.toString(), name: 'AuthService.signInWithApple', error: e);
      return left('Something went wrong');
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
  Future<SignOutEither> signOut({
    List<Future<void>>? futures,
  }) async {
    try {
      await Future.wait(futures ?? []);
      await _auth.signOut();
      return right(unit);
    } catch (e) {
      return left(unit);
    }
  }
}
