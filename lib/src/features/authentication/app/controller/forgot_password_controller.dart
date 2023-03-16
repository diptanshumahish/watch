import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../app/errors/failure.dart';
import '../../data/auth_api.dart';
import '../state/forgot_password_state.dart';

/// Provider for the sign up state
final AutoDisposeStateNotifierProvider<ForgotScreenController,
        ForgotPasswordState> forgotScreenControllerProvider =
    StateNotifierProvider.autoDispose<ForgotScreenController,
        ForgotPasswordState>(
  name: 'LoginControllerProvider',
  (ref) => ForgotScreenController(
    auth: ref.watch(authAPIProvider),
  ),
);

class ForgotScreenController extends StateNotifier<ForgotPasswordState> {
  late final AuthAPI _auth;
  ForgotScreenController({required AuthAPI auth})
      : _auth = auth,
        super(const ForgotInitial());

  Future<void> resetPassword(String email) async {
    state = const ForgotLoading();
    Either<Failure, void> result = await _auth.resetPassword(email: email);
    return result.fold(
      (Failure failure) => state = ForgotFailure(failure),
      (void user) => state = const ForgotSuccess(),
    );
  }
}
