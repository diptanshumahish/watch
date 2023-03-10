// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      displayName: json['displayName'] as String?,
      age: json['age'] as String?,
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

  writeNotNull('displayName', instance.displayName);
  writeNotNull('age', instance.age);
  writeNotNull('email', instance.email);
  val['isAdult'] = instance.isAdult;
  return val;
}

Map<String, dynamic> _$$_UserModelToJson(_$_UserModel instance) =>
    <String, dynamic>{
      'displayName': instance.displayName,
      'age': instance.age,
      'email': instance.email,
      'isAdult': instance.isAdult,
    };
