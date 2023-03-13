import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../app/errors/errors.dart';
import '../../../../models/all_genres_model.dart';
import '../../../../models/movie_details_model.dart';
import '../../data/tmdb_api.dart';
import '../state/search_state.dart';

///exploreSearchControllerPage
final exploreControllerProvider =
    AsyncNotifierProvider<ExploreController, ExploreState>(
  ExploreController.new,
);

class ExploreController extends AsyncNotifier<ExploreState> {
  @override
  Future<ExploreState> build() async {
    Either<Failure, AllGenres> result =
        await ref.watch(tmdbProvider).getAllGenres();
    return result.fold(
      (l) => const ExploreState.initial([]),
      (r) => ExploreState.initial(r.genres),
    );
  }

  Future<void> onSearch(String query) async {
    state = const AsyncLoading();
    Either<Failure, MovieDetail> result =
        await ref.watch(tmdbProvider).getGenreWiseMovies(genre: query);
    result.fold(
      (l) => state = AsyncValue.error(l, StackTrace.current),
      (r) => state = AsyncValue.data(ExploreState.loaded(r)),
    );
  }
}
