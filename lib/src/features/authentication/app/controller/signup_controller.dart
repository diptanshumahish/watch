import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:watch/app/errors/errors.dart';
import 'package:watch/src/features/authentication/app/state/signup_state.dart';
import 'package:watch/src/features/authentication/data/auth_api.dart';
import 'package:watch/src/providers/firestore_provider.dart';

import '../../../../providers/user_provider.dart';

/// Provider for the sign up state
final AutoDisposeStateNotifierProvider<SignUpController, SignUpState>
    signUpControllerProvider =
    StateNotifierProvider.autoDispose<SignUpController, SignUpState>(
  name: 'signUpControllerProvider',
  (ref) => SignUpController(
    auth: ref.watch(authAPIProvider),
    userNotifier: ref.watch(userNotifierProvider.notifier),
    firestoreAPI: ref.watch(firestoreServiceProvider),
  ),
);

class SignUpController extends StateNotifier<SignUpState> {
  SignUpController(
      {required AuthAPI auth,
      required CloudFirestoreAPI firestoreAPI,
      required UserNotifier userNotifier})
      : _auth = auth,
        _firestoreAPI = firestoreAPI,
        _userNotifier = userNotifier,
        super(const SignupInitial());
  late final AuthAPI _auth;
  late final CloudFirestoreAPI _firestoreAPI;
  late final UserNotifier _userNotifier;

  /// Sign up with email & password
  Future<void> signUp({
    required String email,
    required String name,
    required String age,
    required String password,
  }) async {
    state = const SignUpLoading();
    var result = await _auth.signUp(email: email, password: password);
    result.fold(
      (Failure failure) => state = SignUpFailure(failure),
      (UserCredential credential) async {
        await credential.user!.updateDisplayName(name).then(
              (_) => _userNotifier.setUserProps(
                uid: credential.user!.uid,
                displayName: name,
                email: email,
                age: age,
                isAdult: int.parse(age) >= 18 ? true : false,
              ),
            );
        bool firestoreRes =
            await setUserToFirestore(userId: credential.user!.uid);
        if (!firestoreRes) {
          state = const SignUpFailure(
            Failure(message: 'Unable to set your details'),
          );
          return;
        }
        state = const SignupSuccess();
      },
    );
  }

  ///Sets the user to firestore
  Future<bool> setUserToFirestore({required String userId}) async {
    Either<Failure, Unit> result = await _firestoreAPI.setUserDetails(
      userId: userId,
      data: _userNotifier.state,
    );
    return result.isRight();
  }
}
