// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      uid: json['uid'] as String?,
      displayName: json['displayName'] as String?,
      age: json['age'] as String?,
      email: json['email'] as String?,
      selectedGenres: (json['selectedGenres'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      likedItems: (json['likedItems'] as List<dynamic>?)
          ?.map((e) => Result.fromJson(e as Map<String, dynamic>))
          .toList(),
      isAdult: json['isAdult'] as bool,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uid', instance.uid);
  writeNotNull('displayName', instance.displayName);
  writeNotNull('age', instance.age);
  writeNotNull('email', instance.email);
  writeNotNull('selectedGenres', instance.selectedGenres);
  writeNotNull('likedItems', instance.likedItems);
  val['isAdult'] = instance.isAdult;
  return val;
}

Map<String, dynamic> _$$_UserModelToJson(_$_UserModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'displayName': instance.displayName,
      'age': instance.age,
      'email': instance.email,
      'selectedGenres': instance.selectedGenres,
      'likedItems': instance.likedItems,
      'isAdult': instance.isAdult,
    };
