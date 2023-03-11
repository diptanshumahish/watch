import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@Freezed(fromJson: false)
@JsonSerializable(includeIfNull: false)
class UserModel with _$UserModel {
  const factory UserModel({
    String? displayName,
    String? age,
    String? email,
    @Default(false) bool isAdult,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
