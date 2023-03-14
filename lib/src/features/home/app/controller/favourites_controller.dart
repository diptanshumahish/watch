import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:watch/src/providers/firestore_provider.dart';

import '../../../../../app/errors/failure.dart';
import '../state/favourite_state.dart';

///exploreSearchControllerPage
final favouritesControllerProvider =
    AsyncNotifierProvider.autoDispose<FavouritesController, FavouriteState>(
  FavouritesController.new,
);

class FavouritesController extends AutoDisposeAsyncNotifier<FavouriteState> {
  @override
  Future<FavouriteState> build() async {
    state = const AsyncLoading();
    Either<Failure, Map<String, dynamic>> result =
        await ref.watch(firestoreServiceProvider).fetchLikedMovies();
    return result.fold(
      (l) => FavouriteState.error(l),
      (r) {
        if (r['likedItems']?.isEmpty ?? true) {
          return const FavouriteState.empty();
        }
        return FavouriteState.loaded(r['likedItems']);
      },
    );
  }
}
