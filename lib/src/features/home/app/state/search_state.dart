import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../models/all_genres_model.dart';
import '../../../../models/movie_details_model.dart';

part 'search_state.freezed.dart';

@freezed
class ExploreState with _$ExploreState {
  const factory ExploreState.initial(List<Genre> genres) = _Initial;
  const factory ExploreState.loaded(MovieDetail searchResults) = _Loaded;
}
