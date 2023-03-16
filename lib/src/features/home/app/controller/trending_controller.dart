import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../app/errors/failure.dart';
import '../../../../models/movie_details_model.dart';
import '../../data/tmdb_api.dart';
import '../state/trending_state.dart';

///exploreSearchControllerPage
final AsyncNotifierProvider<TrendingController, TrendingState>
    trendingControllerProvider =
    AsyncNotifierProvider<TrendingController, TrendingState>(
  name: 'favouritesControllerProvider',
  TrendingController.new,
);

class TrendingController extends AsyncNotifier<TrendingState> {
  @override
  Future<TrendingState> build() async {
    state = const AsyncLoading<TrendingState>();
    return onInit();
  }

  Future<TrendingState> onInit() async {
    Either<Failure, MovieDetail> result =
        await ref.watch(tmdbProvider).getTrendingMovies();
    return result.fold(
      TrendingState.error,
      (MovieDetail r) {
        if (r.results.isEmpty) {
          return const TrendingState.empty();
        }
        return TrendingState.loaded(r.results);
      },
    );
  }
}
