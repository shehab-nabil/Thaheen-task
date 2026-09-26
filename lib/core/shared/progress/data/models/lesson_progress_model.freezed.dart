// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lesson_progress_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LessonProgressModel {

 String get lessonId; int get positionMs; int get durationMs; bool get isCompleted; int get updatedAt;
/// Create a copy of LessonProgressModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LessonProgressModelCopyWith<LessonProgressModel> get copyWith => _$LessonProgressModelCopyWithImpl<LessonProgressModel>(this as LessonProgressModel, _$identity);

  /// Serializes this LessonProgressModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LessonProgressModel&&(identical(other.lessonId, lessonId) || other.lessonId == lessonId)&&(identical(other.positionMs, positionMs) || other.positionMs == positionMs)&&(identical(other.durationMs, durationMs) || other.durationMs == durationMs)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lessonId,positionMs,durationMs,isCompleted,updatedAt);

@override
String toString() {
  return 'LessonProgressModel(lessonId: $lessonId, positionMs: $positionMs, durationMs: $durationMs, isCompleted: $isCompleted, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $LessonProgressModelCopyWith<$Res>  {
  factory $LessonProgressModelCopyWith(LessonProgressModel value, $Res Function(LessonProgressModel) _then) = _$LessonProgressModelCopyWithImpl;
@useResult
$Res call({
 String lessonId, int positionMs, int durationMs, bool isCompleted, int updatedAt
});




}
/// @nodoc
class _$LessonProgressModelCopyWithImpl<$Res>
    implements $LessonProgressModelCopyWith<$Res> {
  _$LessonProgressModelCopyWithImpl(this._self, this._then);

  final LessonProgressModel _self;
  final $Res Function(LessonProgressModel) _then;

/// Create a copy of LessonProgressModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lessonId = null,Object? positionMs = null,Object? durationMs = null,Object? isCompleted = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
lessonId: null == lessonId ? _self.lessonId : lessonId // ignore: cast_nullable_to_non_nullable
as String,positionMs: null == positionMs ? _self.positionMs : positionMs // ignore: cast_nullable_to_non_nullable
as int,durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [LessonProgressModel].
extension LessonProgressModelPatterns on LessonProgressModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LessonProgressModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LessonProgressModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LessonProgressModel value)  $default,){
final _that = this;
switch (_that) {
case _LessonProgressModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LessonProgressModel value)?  $default,){
final _that = this;
switch (_that) {
case _LessonProgressModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String lessonId,  int positionMs,  int durationMs,  bool isCompleted,  int updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LessonProgressModel() when $default != null:
return $default(_that.lessonId,_that.positionMs,_that.durationMs,_that.isCompleted,_that.updatedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String lessonId,  int positionMs,  int durationMs,  bool isCompleted,  int updatedAt)  $default,) {final _that = this;
switch (_that) {
case _LessonProgressModel():
return $default(_that.lessonId,_that.positionMs,_that.durationMs,_that.isCompleted,_that.updatedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String lessonId,  int positionMs,  int durationMs,  bool isCompleted,  int updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _LessonProgressModel() when $default != null:
return $default(_that.lessonId,_that.positionMs,_that.durationMs,_that.isCompleted,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LessonProgressModel implements LessonProgressModel {
  const _LessonProgressModel({required this.lessonId, required this.positionMs, required this.durationMs, required this.isCompleted, required this.updatedAt});
  factory _LessonProgressModel.fromJson(Map<String, dynamic> json) => _$LessonProgressModelFromJson(json);

@override final  String lessonId;
@override final  int positionMs;
@override final  int durationMs;
@override final  bool isCompleted;
@override final  int updatedAt;

/// Create a copy of LessonProgressModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LessonProgressModelCopyWith<_LessonProgressModel> get copyWith => __$LessonProgressModelCopyWithImpl<_LessonProgressModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LessonProgressModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LessonProgressModel&&(identical(other.lessonId, lessonId) || other.lessonId == lessonId)&&(identical(other.positionMs, positionMs) || other.positionMs == positionMs)&&(identical(other.durationMs, durationMs) || other.durationMs == durationMs)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lessonId,positionMs,durationMs,isCompleted,updatedAt);

@override
String toString() {
  return 'LessonProgressModel(lessonId: $lessonId, positionMs: $positionMs, durationMs: $durationMs, isCompleted: $isCompleted, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$LessonProgressModelCopyWith<$Res> implements $LessonProgressModelCopyWith<$Res> {
  factory _$LessonProgressModelCopyWith(_LessonProgressModel value, $Res Function(_LessonProgressModel) _then) = __$LessonProgressModelCopyWithImpl;
@override @useResult
$Res call({
 String lessonId, int positionMs, int durationMs, bool isCompleted, int updatedAt
});




}
/// @nodoc
class __$LessonProgressModelCopyWithImpl<$Res>
    implements _$LessonProgressModelCopyWith<$Res> {
  __$LessonProgressModelCopyWithImpl(this._self, this._then);

  final _LessonProgressModel _self;
  final $Res Function(_LessonProgressModel) _then;

/// Create a copy of LessonProgressModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lessonId = null,Object? positionMs = null,Object? durationMs = null,Object? isCompleted = null,Object? updatedAt = null,}) {
  return _then(_LessonProgressModel(
lessonId: null == lessonId ? _self.lessonId : lessonId // ignore: cast_nullable_to_non_nullable
as String,positionMs: null == positionMs ? _self.positionMs : positionMs // ignore: cast_nullable_to_non_nullable
as int,durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
