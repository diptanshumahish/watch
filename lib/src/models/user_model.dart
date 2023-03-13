import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:watch/src/models/movie_details_model.dart' show Result;

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@Freezed(fromJson: false)
@JsonSerializable(includeIfNull: false)
class UserModel with _$UserModel {
  const factory UserModel({
    String? uid,
    String? displayName,
    String? age,
    String? email,
    List<String>? selectedGenres,
    List<Result>? likedItems,
    @Default(false) bool isAdult,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
