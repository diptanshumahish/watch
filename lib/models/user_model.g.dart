// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      user: json['user'] as String?,
      displayName: json['displayName'] as String?,
      email: json['email'] as String?,
      isAdult: json['isAdult'] as bool,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('user', instance.user);
  writeNotNull('displayName', instance.displayName);
  writeNotNull('email', instance.email);
  val['isAdult'] = instance.isAdult;
  return val;
}

Map<String, dynamic> _$$_UserModelToJson(_$_UserModel instance) =>
    <String, dynamic>{
      'user': instance.user,
      'displayName': instance.displayName,
      'email': instance.email,
      'isAdult': instance.isAdult,
    };
