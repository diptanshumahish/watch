import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:watch/src/features/authentication/data/auth_api.dart';

import '../models/user_model.dart';

///User notifier provider
final userNotifierProvider = StateNotifierProvider<UserNotifier, UserModel>(
  (Ref ref) => UserNotifier(ref: ref),
);

class UserNotifier extends StateNotifier<UserModel> {
  final Ref _ref;
  UserNotifier({required Ref ref})
      : _ref = ref,
        super(const UserModel());

  bool get isUidNotEmpty => state.uid != null;

  bool get isUserAdult => state.isAdult;

  User? currentUser() => _ref.watch(firebaseAuthProvider).currentUser;

  void setUser(UserModel user) => state = user;

  void setUserProps({
    String? displayName,
    String? age,
    String? email,
    List<String>? selectedGenres,
    List<String>? likedItems,
    bool isAdult = false,
  }) =>
      state = state.copyWith(
        displayName: displayName,
        age: age,
        email: email,
        selectedGenres: selectedGenres,
        likedItems: likedItems,
        isAdult: isAdult,
      );

  void clearUser() => state = const UserModel();
}
