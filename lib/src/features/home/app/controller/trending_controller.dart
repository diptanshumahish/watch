import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:watch/src/features/home/app/state/trending_state.dart';
import 'package:watch/src/features/home/data/tmdb_api.dart';
import 'package:watch/src/models/movie_details_model.dart';

import '../../../../../app/errors/failure.dart';

///exploreSearchControllerPage
final trendingControllerProvider =
    AsyncNotifierProvider<TrendingController, TrendingState>(
  name: 'favouritesControllerProvider',
  TrendingController.new,
);

class TrendingController extends AsyncNotifier<TrendingState> {
  @override
  Future<TrendingState> build() async {
    state = const AsyncLoading();
    return await onInit();
  }

  Future<TrendingState> onInit() async {
    Either<Failure, MovieDetail> result =
        await ref.watch(tmdbProvider).getTrendingMovies();
    return result.fold(
      (l) => TrendingState.error(l),
      (r) {
        if (r.results.isEmpty) {
          return const TrendingState.empty();
        }
        return TrendingState.loaded(r.results);
      },
    );
  }
}
