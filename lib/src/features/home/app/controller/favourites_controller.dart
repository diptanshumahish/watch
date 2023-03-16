import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../app/errors/failure.dart';
import '../../../../providers/firestore_provider.dart';
import '../state/favourite_state.dart';

///exploreSearchControllerPage
final AsyncNotifierProvider<FavouritesController, FavouriteState>
    favouritesControllerProvider =
    AsyncNotifierProvider<FavouritesController, FavouriteState>(
  name: 'favouritesControllerProvider',
  FavouritesController.new,
);

class FavouritesController extends AsyncNotifier<FavouriteState> {
  @override
  Future<FavouriteState> build() async {
    state = const AsyncLoading<FavouriteState>();
    return onInit();
  }

  Future<FavouriteState> onInit() async {
    Either<Failure, Map<String, dynamic>> result =
        await ref.watch(firestoreServiceProvider).fetchLikedMovies();
    return result.fold(
      FavouriteState.error,
      (Map<String, dynamic> r) {
        if (r['likedItems']?.isEmpty ?? true) {
          return const FavouriteState.empty();
        }
        return FavouriteState.loaded(r['likedItems']);
      },
    );
  }
}
