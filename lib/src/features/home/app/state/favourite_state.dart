import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:watch/app/errors/errors.dart';

part 'favourite_state.freezed.dart';

@freezed
class FavouriteState with _$FavouriteState {
  const factory FavouriteState.error(Failure failure) = _Error;
  const factory FavouriteState.empty() = _Empty;
  const factory FavouriteState.loaded(List<dynamic> favResults) = _Loaded;
}
