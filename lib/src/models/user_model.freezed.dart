// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$UserModel {
  String? get uid => throw _privateConstructorUsedError;
  String? get displayName => throw _privateConstructorUsedError;
  String? get age => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  List<String>? get selectedGenres => throw _privateConstructorUsedError;
  List<Result>? get likedItems => throw _privateConstructorUsedError;
  bool get isAdult => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res, UserModel>;
  @useResult
  $Res call(
      {String? uid,
      String? displayName,
      String? age,
      String? email,
      List<String>? selectedGenres,
      List<Result>? likedItems,
      bool isAdult});
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res, $Val extends UserModel>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = freezed,
    Object? displayName = freezed,
    Object? age = freezed,
    Object? email = freezed,
    Object? selectedGenres = freezed,
    Object? likedItems = freezed,
    Object? isAdult = null,
  }) {
    return _then(_value.copyWith(
      uid: freezed == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String?,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      age: freezed == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedGenres: freezed == selectedGenres
          ? _value.selectedGenres
          : selectedGenres // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      likedItems: freezed == likedItems
          ? _value.likedItems
          : likedItems // ignore: cast_nullable_to_non_nullable
              as List<Result>?,
      isAdult: null == isAdult
          ? _value.isAdult
          : isAdult // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UserModelCopyWith<$Res> implements $UserModelCopyWith<$Res> {
  factory _$$_UserModelCopyWith(
          _$_UserModel value, $Res Function(_$_UserModel) then) =
      __$$_UserModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? uid,
      String? displayName,
      String? age,
      String? email,
      List<String>? selectedGenres,
      List<Result>? likedItems,
      bool isAdult});
}

/// @nodoc
class __$$_UserModelCopyWithImpl<$Res>
    extends _$UserModelCopyWithImpl<$Res, _$_UserModel>
    implements _$$_UserModelCopyWith<$Res> {
  __$$_UserModelCopyWithImpl(
      _$_UserModel _value, $Res Function(_$_UserModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = freezed,
    Object? displayName = freezed,
    Object? age = freezed,
    Object? email = freezed,
    Object? selectedGenres = freezed,
    Object? likedItems = freezed,
    Object? isAdult = null,
  }) {
    return _then(_$_UserModel(
      uid: freezed == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String?,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      age: freezed == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedGenres: freezed == selectedGenres
          ? _value._selectedGenres
          : selectedGenres // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      likedItems: freezed == likedItems
          ? _value._likedItems
          : likedItems // ignore: cast_nullable_to_non_nullable
              as List<Result>?,
      isAdult: null == isAdult
          ? _value.isAdult
          : isAdult // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable(createFactory: false)
class _$_UserModel implements _UserModel {
  const _$_UserModel(
      {this.uid,
      this.displayName,
      this.age,
      this.email,
      final List<String>? selectedGenres,
      final List<Result>? likedItems,
      this.isAdult = false})
      : _selectedGenres = selectedGenres,
        _likedItems = likedItems;

  @override
  final String? uid;
  @override
  final String? displayName;
  @override
  final String? age;
  @override
  final String? email;
  final List<String>? _selectedGenres;
  @override
  List<String>? get selectedGenres {
    final value = _selectedGenres;
    if (value == null) return null;
    if (_selectedGenres is EqualUnmodifiableListView) return _selectedGenres;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<Result>? _likedItems;
  @override
  List<Result>? get likedItems {
    final value = _likedItems;
    if (value == null) return null;
    if (_likedItems is EqualUnmodifiableListView) return _likedItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey()
  final bool isAdult;

  @override
  String toString() {
    return 'UserModel(uid: $uid, displayName: $displayName, age: $age, email: $email, selectedGenres: $selectedGenres, likedItems: $likedItems, isAdult: $isAdult)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserModel &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.email, email) || other.email == email) &&
            const DeepCollectionEquality()
                .equals(other._selectedGenres, _selectedGenres) &&
            const DeepCollectionEquality()
                .equals(other._likedItems, _likedItems) &&
            (identical(other.isAdult, isAdult) || other.isAdult == isAdult));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      uid,
      displayName,
      age,
      email,
      const DeepCollectionEquality().hash(_selectedGenres),
      const DeepCollectionEquality().hash(_likedItems),
      isAdult);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserModelCopyWith<_$_UserModel> get copyWith =>
      __$$_UserModelCopyWithImpl<_$_UserModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserModelToJson(
      this,
    );
  }
}

abstract class _UserModel implements UserModel {
  const factory _UserModel(
      {final String? uid,
      final String? displayName,
      final String? age,
      final String? email,
      final List<String>? selectedGenres,
      final List<Result>? likedItems,
      final bool isAdult}) = _$_UserModel;

  @override
  String? get uid;
  @override
  String? get displayName;
  @override
  String? get age;
  @override
  String? get email;
  @override
  List<String>? get selectedGenres;
  @override
  List<Result>? get likedItems;
  @override
  bool get isAdult;
  @override
  @JsonKey(ignore: true)
  _$$_UserModelCopyWith<_$_UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}
