import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../app/errors/failure.dart';
import '../../../../models/movie_details_model.dart';

part 'trending_state.freezed.dart';

@freezed
class TrendingState with _$TrendingState {
  const factory TrendingState.error(Failure failure) = _Error;
  const factory TrendingState.empty() = _Empty;
  const factory TrendingState.loaded(List<Result> data) = _Loaded;
}
