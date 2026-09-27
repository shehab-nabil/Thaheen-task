// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'continue_watching_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ContinueWatchingModel {

 String get courseId; String get lessonId; LocalizedTextModel get courseTitle; LocalizedTextModel get sectionTitle; LocalizedTextModel get lessonTitle; int get lessonIndex; int get totalLessons; int get positionMs; int get durationMs;
/// Create a copy of ContinueWatchingModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContinueWatchingModelCopyWith<ContinueWatchingModel> get copyWith => _$ContinueWatchingModelCopyWithImpl<ContinueWatchingModel>(this as ContinueWatchingModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContinueWatchingModel&&(identical(other.courseId, courseId) || other.courseId == courseId)&&(identical(other.lessonId, lessonId) || other.lessonId == lessonId)&&(identical(other.courseTitle, courseTitle) || other.courseTitle == courseTitle)&&(identical(other.sectionTitle, sectionTitle) || other.sectionTitle == sectionTitle)&&(identical(other.lessonTitle, lessonTitle) || other.lessonTitle == lessonTitle)&&(identical(other.lessonIndex, lessonIndex) || other.lessonIndex == lessonIndex)&&(identical(other.totalLessons, totalLessons) || other.totalLessons == totalLessons)&&(identical(other.positionMs, positionMs) || other.positionMs == positionMs)&&(identical(other.durationMs, durationMs) || other.durationMs == durationMs));
}


@override
int get hashCode => Object.hash(runtimeType,courseId,lessonId,courseTitle,sectionTitle,lessonTitle,lessonIndex,totalLessons,positionMs,durationMs);

@override
String toString() {
  return 'ContinueWatchingModel(courseId: $courseId, lessonId: $lessonId, courseTitle: $courseTitle, sectionTitle: $sectionTitle, lessonTitle: $lessonTitle, lessonIndex: $lessonIndex, totalLessons: $totalLessons, positionMs: $positionMs, durationMs: $durationMs)';
}


}

/// @nodoc
abstract mixin class $ContinueWatchingModelCopyWith<$Res>  {
  factory $ContinueWatchingModelCopyWith(ContinueWatchingModel value, $Res Function(ContinueWatchingModel) _then) = _$ContinueWatchingModelCopyWithImpl;
@useResult
$Res call({
 String courseId, String lessonId, LocalizedTextModel courseTitle, LocalizedTextModel sectionTitle, LocalizedTextModel lessonTitle, int lessonIndex, int totalLessons, int positionMs, int durationMs
});


$LocalizedTextModelCopyWith<$Res> get courseTitle;$LocalizedTextModelCopyWith<$Res> get sectionTitle;$LocalizedTextModelCopyWith<$Res> get lessonTitle;

}
/// @nodoc
class _$ContinueWatchingModelCopyWithImpl<$Res>
    implements $ContinueWatchingModelCopyWith<$Res> {
  _$ContinueWatchingModelCopyWithImpl(this._self, this._then);

  final ContinueWatchingModel _self;
  final $Res Function(ContinueWatchingModel) _then;

/// Create a copy of ContinueWatchingModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? courseId = null,Object? lessonId = null,Object? courseTitle = null,Object? sectionTitle = null,Object? lessonTitle = null,Object? lessonIndex = null,Object? totalLessons = null,Object? positionMs = null,Object? durationMs = null,}) {
  return _then(_self.copyWith(
courseId: null == courseId ? _self.courseId : courseId // ignore: cast_nullable_to_non_nullable
as String,lessonId: null == lessonId ? _self.lessonId : lessonId // ignore: cast_nullable_to_non_nullable
as String,courseTitle: null == courseTitle ? _self.courseTitle : courseTitle // ignore: cast_nullable_to_non_nullable
as LocalizedTextModel,sectionTitle: null == sectionTitle ? _self.sectionTitle : sectionTitle // ignore: cast_nullable_to_non_nullable
as LocalizedTextModel,lessonTitle: null == lessonTitle ? _self.lessonTitle : lessonTitle // ignore: cast_nullable_to_non_nullable
as LocalizedTextModel,lessonIndex: null == lessonIndex ? _self.lessonIndex : lessonIndex // ignore: cast_nullable_to_non_nullable
as int,totalLessons: null == totalLessons ? _self.totalLessons : totalLessons // ignore: cast_nullable_to_non_nullable
as int,positionMs: null == positionMs ? _self.positionMs : positionMs // ignore: cast_nullable_to_non_nullable
as int,durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of ContinueWatchingModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextModelCopyWith<$Res> get courseTitle {
  
  return $LocalizedTextModelCopyWith<$Res>(_self.courseTitle, (value) {
    return _then(_self.copyWith(courseTitle: value));
  });
}/// Create a copy of ContinueWatchingModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextModelCopyWith<$Res> get sectionTitle {
  
  return $LocalizedTextModelCopyWith<$Res>(_self.sectionTitle, (value) {
    return _then(_self.copyWith(sectionTitle: value));
  });
}/// Create a copy of ContinueWatchingModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextModelCopyWith<$Res> get lessonTitle {
  
  return $LocalizedTextModelCopyWith<$Res>(_self.lessonTitle, (value) {
    return _then(_self.copyWith(lessonTitle: value));
  });
}
}


/// Adds pattern-matching-related methods to [ContinueWatchingModel].
extension ContinueWatchingModelPatterns on ContinueWatchingModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ContinueWatchingModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ContinueWatchingModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ContinueWatchingModel value)  $default,){
final _that = this;
switch (_that) {
case _ContinueWatchingModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ContinueWatchingModel value)?  $default,){
final _that = this;
switch (_that) {
case _ContinueWatchingModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String courseId,  String lessonId,  LocalizedTextModel courseTitle,  LocalizedTextModel sectionTitle,  LocalizedTextModel lessonTitle,  int lessonIndex,  int totalLessons,  int positionMs,  int durationMs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ContinueWatchingModel() when $default != null:
return $default(_that.courseId,_that.lessonId,_that.courseTitle,_that.sectionTitle,_that.lessonTitle,_that.lessonIndex,_that.totalLessons,_that.positionMs,_that.durationMs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String courseId,  String lessonId,  LocalizedTextModel courseTitle,  LocalizedTextModel sectionTitle,  LocalizedTextModel lessonTitle,  int lessonIndex,  int totalLessons,  int positionMs,  int durationMs)  $default,) {final _that = this;
switch (_that) {
case _ContinueWatchingModel():
return $default(_that.courseId,_that.lessonId,_that.courseTitle,_that.sectionTitle,_that.lessonTitle,_that.lessonIndex,_that.totalLessons,_that.positionMs,_that.durationMs);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String courseId,  String lessonId,  LocalizedTextModel courseTitle,  LocalizedTextModel sectionTitle,  LocalizedTextModel lessonTitle,  int lessonIndex,  int totalLessons,  int positionMs,  int durationMs)?  $default,) {final _that = this;
switch (_that) {
case _ContinueWatchingModel() when $default != null:
return $default(_that.courseId,_that.lessonId,_that.courseTitle,_that.sectionTitle,_that.lessonTitle,_that.lessonIndex,_that.totalLessons,_that.positionMs,_that.durationMs);case _:
  return null;

}
}

}

/// @nodoc


class _ContinueWatchingModel implements ContinueWatchingModel {
  const _ContinueWatchingModel({required this.courseId, required this.lessonId, required this.courseTitle, required this.sectionTitle, required this.lessonTitle, required this.lessonIndex, required this.totalLessons, required this.positionMs, required this.durationMs});
  

@override final  String courseId;
@override final  String lessonId;
@override final  LocalizedTextModel courseTitle;
@override final  LocalizedTextModel sectionTitle;
@override final  LocalizedTextModel lessonTitle;
@override final  int lessonIndex;
@override final  int totalLessons;
@override final  int positionMs;
@override final  int durationMs;

/// Create a copy of ContinueWatchingModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContinueWatchingModelCopyWith<_ContinueWatchingModel> get copyWith => __$ContinueWatchingModelCopyWithImpl<_ContinueWatchingModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ContinueWatchingModel&&(identical(other.courseId, courseId) || other.courseId == courseId)&&(identical(other.lessonId, lessonId) || other.lessonId == lessonId)&&(identical(other.courseTitle, courseTitle) || other.courseTitle == courseTitle)&&(identical(other.sectionTitle, sectionTitle) || other.sectionTitle == sectionTitle)&&(identical(other.lessonTitle, lessonTitle) || other.lessonTitle == lessonTitle)&&(identical(other.lessonIndex, lessonIndex) || other.lessonIndex == lessonIndex)&&(identical(other.totalLessons, totalLessons) || other.totalLessons == totalLessons)&&(identical(other.positionMs, positionMs) || other.positionMs == positionMs)&&(identical(other.durationMs, durationMs) || other.durationMs == durationMs));
}


@override
int get hashCode => Object.hash(runtimeType,courseId,lessonId,courseTitle,sectionTitle,lessonTitle,lessonIndex,totalLessons,positionMs,durationMs);

@override
String toString() {
  return 'ContinueWatchingModel(courseId: $courseId, lessonId: $lessonId, courseTitle: $courseTitle, sectionTitle: $sectionTitle, lessonTitle: $lessonTitle, lessonIndex: $lessonIndex, totalLessons: $totalLessons, positionMs: $positionMs, durationMs: $durationMs)';
}


}

/// @nodoc
abstract mixin class _$ContinueWatchingModelCopyWith<$Res> implements $ContinueWatchingModelCopyWith<$Res> {
  factory _$ContinueWatchingModelCopyWith(_ContinueWatchingModel value, $Res Function(_ContinueWatchingModel) _then) = __$ContinueWatchingModelCopyWithImpl;
@override @useResult
$Res call({
 String courseId, String lessonId, LocalizedTextModel courseTitle, LocalizedTextModel sectionTitle, LocalizedTextModel lessonTitle, int lessonIndex, int totalLessons, int positionMs, int durationMs
});


@override $LocalizedTextModelCopyWith<$Res> get courseTitle;@override $LocalizedTextModelCopyWith<$Res> get sectionTitle;@override $LocalizedTextModelCopyWith<$Res> get lessonTitle;

}
/// @nodoc
class __$ContinueWatchingModelCopyWithImpl<$Res>
    implements _$ContinueWatchingModelCopyWith<$Res> {
  __$ContinueWatchingModelCopyWithImpl(this._self, this._then);

  final _ContinueWatchingModel _self;
  final $Res Function(_ContinueWatchingModel) _then;

/// Create a copy of ContinueWatchingModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? courseId = null,Object? lessonId = null,Object? courseTitle = null,Object? sectionTitle = null,Object? lessonTitle = null,Object? lessonIndex = null,Object? totalLessons = null,Object? positionMs = null,Object? durationMs = null,}) {
  return _then(_ContinueWatchingModel(
courseId: null == courseId ? _self.courseId : courseId // ignore: cast_nullable_to_non_nullable
as String,lessonId: null == lessonId ? _self.lessonId : lessonId // ignore: cast_nullable_to_non_nullable
as String,courseTitle: null == courseTitle ? _self.courseTitle : courseTitle // ignore: cast_nullable_to_non_nullable
as LocalizedTextModel,sectionTitle: null == sectionTitle ? _self.sectionTitle : sectionTitle // ignore: cast_nullable_to_non_nullable
as LocalizedTextModel,lessonTitle: null == lessonTitle ? _self.lessonTitle : lessonTitle // ignore: cast_nullable_to_non_nullable
as LocalizedTextModel,lessonIndex: null == lessonIndex ? _self.lessonIndex : lessonIndex // ignore: cast_nullable_to_non_nullable
as int,totalLessons: null == totalLessons ? _self.totalLessons : totalLessons // ignore: cast_nullable_to_non_nullable
as int,positionMs: null == positionMs ? _self.positionMs : positionMs // ignore: cast_nullable_to_non_nullable
as int,durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of ContinueWatchingModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextModelCopyWith<$Res> get courseTitle {
  
  return $LocalizedTextModelCopyWith<$Res>(_self.courseTitle, (value) {
    return _then(_self.copyWith(courseTitle: value));
  });
}/// Create a copy of ContinueWatchingModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextModelCopyWith<$Res> get sectionTitle {
  
  return $LocalizedTextModelCopyWith<$Res>(_self.sectionTitle, (value) {
    return _then(_self.copyWith(sectionTitle: value));
  });
}/// Create a copy of ContinueWatchingModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextModelCopyWith<$Res> get lessonTitle {
  
  return $LocalizedTextModelCopyWith<$Res>(_self.lessonTitle, (value) {
    return _then(_self.copyWith(lessonTitle: value));
  });
}
}

// dart format on
