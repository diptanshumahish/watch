import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../models/all_genres_model.dart';
import '../../../../models/genres_model.dart';

part 'search_state.freezed.dart';

@freezed
abstract class ExploreState with _$ExploreState {
  const factory ExploreState.initial(List<Genre> genres) = _Initial;
  const factory ExploreState.loaded(MovieDetail searchResults) = _Loaded;
}
