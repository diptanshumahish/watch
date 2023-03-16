import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../app/utils/snackbar/snackbar.dart';
import '../../../../providers/user_provider.dart';
import '../../../../routes/app_routes.dart';
import '../../../authentication/data/auth_api.dart';

final logoutNotifierProvider =
    ChangeNotifierProvider.autoDispose<LogoutNotifier>(
  (ref) => LogoutNotifier(
      ref.watch(authAPIProvider), ref.watch(userNotifierProvider.notifier)),
);

class LogoutNotifier extends ChangeNotifier {
  LogoutNotifier(this._authAPI, this._userNotifier);

  late final AuthAPI _authAPI;
  late final UserNotifier _userNotifier;

  Future<void> logout(BuildContext context) async {
    await _authAPI.signOut().then(
          (value) => value.fold(
            (l) => context.showSnackBar('Unable to logout', isError: true),
            (r) {
              _userNotifier.clearUser();
              WidgetsBinding.instance.addPostFrameCallback((_) {
                context.showSnackBar('Logged Out Successfully');
              });
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(loginRoute, (route) => false);
            },
          ),
        );
  }
}
