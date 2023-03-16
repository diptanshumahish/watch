import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../app/errors/failure.dart';
import '../../../../providers/user_provider.dart';
import '../../data/auth_api.dart';
import '../state/login_state.dart';

/// Provider for the sign up state
final AutoDisposeStateNotifierProvider<LoginController, LoginState>
    loginControllerProvider =
    StateNotifierProvider.autoDispose<LoginController, LoginState>(
  name: 'LoginControllerProvider',
  (AutoDisposeStateNotifierProviderRef<LoginController, LoginState> ref) =>
      LoginController(
    auth: ref.watch(authAPIProvider),
    userNotifier: ref.watch(userNotifierProvider.notifier),
  ),
);

class LoginController extends StateNotifier<LoginState> {
  late final AuthAPI _auth;
  late final UserNotifier _userNotifier;
  LoginController({required AuthAPI auth, required UserNotifier userNotifier})
      : _auth = auth,
        _userNotifier = userNotifier,
        super(const LoginInitial());

  Future<void> loginWithEmail(
      {required String email, required String password}) async {
    state = const LoginLoading();
    Either<Failure, UserCredential> result = await _auth
        .signInWithEmailAndPassword(email: email, password: password);
    return result.fold(
      (Failure failure) => state = LoginFailure(failure),
      (UserCredential user) {
        if (user.user?.uid == null) {
          state = LoginFailure(Failure(
              message: 'Unable to get user id',
              stackTrace: StackTrace.current));
          return;
        }
        _userNotifier.setUserProps(
          uid: user.user!.uid,
          displayName: user.user!.displayName,
          email: user.user!.email,
        );
        state = const LoginSuccess();
      },
    );
  }

  Future<void> loginWithGoogle() async {
    state = const LoginLoading();
    Either<Failure, UserCredential> result = await _auth.signInWithGoogle();
    return result.fold(
      (Failure failure) => state = LoginFailure(failure),
      (UserCredential user) {
        if (user.user?.uid == null) {
          state = LoginFailure(Failure(
            message: 'Unable to get user id',
            stackTrace: StackTrace.current,
          ));
          return;
        }
        _userNotifier.setUserProps(
          uid: user.user!.uid,
          displayName: user.user!.displayName,
          email: user.user!.email,
        );
        state = const LoginSuccess();
      },
    );
  }
}
