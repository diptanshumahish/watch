import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:watch/src/features/authentication/data/auth_api.dart';
import 'package:watch/src/models/movie_details_model.dart';

import '../models/user_model.dart';

///User notifier provider
final userNotifierProvider = StateNotifierProvider<UserNotifier, UserModel>(
  name: 'userNotifierProvider',
  (Ref ref) => UserNotifier(ref: ref),
);

class UserNotifier extends StateNotifier<UserModel> {
  final Ref _ref;
  UserNotifier({required Ref ref})
      : _ref = ref,
        super(const UserModel());

  bool get isUidNotEmpty => state.uid != null;

  bool get isUserAdult => state.isAdult;

  UserModel get user => state;

  User? currentUser() => _ref.watch(firebaseAuthProvider).currentUser;

  void setUser(UserModel user) => state = user;

  void updateLikedItems(Result likedItem) {
    if (state.likedItems != null) {
      state = state.copyWith(likedItems: [...state.likedItems!, likedItem]);
      return;
    }
    state = state.copyWith(likedItems: [likedItem]);
    return;
  }

  void setUserProps({
    String? displayName,
    String? age,
    String? uid,
    String? email,
    List<String>? selectedGenres,
    bool isAdult = false,
  }) =>
      state = state.copyWith(
        displayName: displayName,
        age: age,
        uid: uid,
        email: email,
        selectedGenres: selectedGenres,
        isAdult: isAdult,
      );

  void clearUser() => state = const UserModel();
}
