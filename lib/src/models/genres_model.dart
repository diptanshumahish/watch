import 'package:freezed_annotation/freezed_annotation.dart';

part 'genres_model.freezed.dart';
part 'genres_model.g.dart';

@freezed
class MovieDetail with _$MovieDetail {
  const factory MovieDetail({
    @Default(0) int page,
    @Default(<Result>[]) List<Result> results,
    @Default(0) int totalPages,
    @Default(0) int totalResults,
  }) = _MovieDetail;

  factory MovieDetail.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailFromJson(json);
}

@Freezed(fromJson: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class Result with _$Result {
  const factory Result({
    @Default(false) bool adult,
    String? backdropPath,
    @Default(<int>[]) List<int> genreIds,
    int? id,
    String? originalLanguage,
    String? originalTitle,
    String? overview,
    double? popularity,
    String? posterPath,
    String? releaseDate,
    String? title,
    @Default(false) bool video,
    double? voteAverage,
    @Default(0) int voteCount,
  }) = _Result;

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);
}
