import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

typedef SignOutEither = Either<Unit, Unit>;
typedef SignInEither = Either<String, UserCredential>;
typedef SignUpEither = Either<String, UserCredential>;

class AuthService {
  AuthService(this._auth);

  late final FirebaseAuth _auth;

  ///Auth instance getter
  ///Use this to access the [FirebaseAuth] instance
  FirebaseAuth get auth => _auth;

  ///Auth status change user stream
  Stream<User?> get user => _auth.authStateChanges();

  ///Signin user anonymously
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
  Future<SignInEither> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return right(result);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return left('No user found for these credentials.');
      } else if (e.code == 'wrong-password') {
        return left('Wrong password provided for the user');
      }
      return left('Something went wrong');
    }
  }

  ///Sign in user with Google returns [SignInEither] i.e. if
  ///the user is signed in successfully then it returns [UserCredential]else
  ///it returns [String] error message
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
  Future<SignUpEither> signUp(
      {required String email, required String password}) async {
    try {
      UserCredential user = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return right(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return left('The password is too weak');
      } else if (e.code == 'email-already-in-use') {
        return left('The account already exists for that email.');
      } else if (e.code == 'invalid-email') {
        return left('The email is invalid.');
      } else if (e.code == 'operation-not-allowed') {
        return left('Unable to create user.');
      }
      return left('Something went wrong.');
    }
  }

  /// Sign out user and end the session
  /// Optional [futures] is a list of futures that will be executed before signing out
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
