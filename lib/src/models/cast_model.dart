// ignore_for_file: constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

part 'cast_model.freezed.dart';
part 'cast_model.g.dart';

@Freezed(fromJson: false,toJson: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class AllCredits with _$AllCredits {
  const factory AllCredits({
    int? id,
    @Default(<Cast>[]) List<Cast> cast,
    @Default(<Cast>[]) List<Cast> crew,
  }) = _AllCredits;

  factory AllCredits.fromJson(Map<String, dynamic> json) =>
      _$AllCreditsFromJson(json);
}

@Freezed(fromJson: false,toJson: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class Cast with _$Cast {
  const factory Cast({
    @Default(false) bool adult,
    int? gender,
    int? id,
    //Todo: KnownForDepartment? knownForDepartment, add later when all possible values are known
    // KnownForDepartment? knownForDepartment,
    String? name,
    String? originalName,
    double? popularity,
    String? profilePath,
    int? castId,
    String? character,
    String? creditId,
    int? order,
    String? department,
    String? job,
  }) = _Cast;

  factory Cast.fromJson(Map<String, dynamic> json) => _$CastFromJson(json);
}

enum KnownForDepartment {
  @JsonValue("Acting")
  ACTING,
  @JsonValue("Editing")
  EDITING,
  @JsonValue("Production")
  PRODUCTION,
  @JsonValue("Camera")
  CAMERA,
  @JsonValue("Sound")
  SOUND,
  @JsonValue("Crew")
  CREW,
}
