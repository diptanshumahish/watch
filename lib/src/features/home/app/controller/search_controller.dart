import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../app/errors/errors.dart';
import '../../../../models/all_genres_model.dart';
import '../../../../models/movie_details_model.dart';
import '../../data/tmdb_api.dart';
import '../state/search_state.dart';

///exploreSearchControllerPage
final AutoDisposeAsyncNotifierProvider<ExploreController, ExploreState>
    exploreControllerProvider =
    AsyncNotifierProvider.autoDispose<ExploreController, ExploreState>(
  name: 'exploreControllerProvider',
  ExploreController.new,
);

class ExploreController extends AutoDisposeAsyncNotifier<ExploreState> {
  @override
  Future<ExploreState> build() async {
    Either<Failure, AllGenres> result =
        await ref.watch(tmdbProvider).getAllGenres();
    return result.fold(
      (Failure l) => const ExploreState.initial(<Genre>[]),
      (AllGenres r) => ExploreState.initial(r.genres),
    );
  }

  Future<void> onSearch(String query) async {
    state = const AsyncLoading<ExploreState>();
    Either<Failure, MovieDetail> result =
        await ref.watch(tmdbProvider).getGenreWiseMovies(genre: query);
    result.fold(
      (Failure l) =>
          state = AsyncValue<ExploreState>.error(l, StackTrace.current),
      (MovieDetail r) =>
          state = AsyncValue<ExploreState>.data(ExploreState.loaded(r)),
    );
  }
}
