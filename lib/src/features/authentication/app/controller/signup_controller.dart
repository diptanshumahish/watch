import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../app/errors/errors.dart';
import '../../../../providers/firestore_provider.dart';
import '../../../../providers/user_provider.dart';
import '../../data/auth_api.dart';
import '../state/signup_state.dart';

/// Provider for the sign up state
final AutoDisposeStateNotifierProvider<SignUpController, SignUpState>
    signUpControllerProvider =
    StateNotifierProvider.autoDispose<SignUpController, SignUpState>(
  name: 'signUpControllerProvider',
  (AutoDisposeStateNotifierProviderRef<SignUpController, SignUpState> ref) =>
      SignUpController(
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
    Either<Failure, UserCredential> result =
        await _auth.signUp(email: email, password: password);
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
