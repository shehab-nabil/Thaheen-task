// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'player_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PlayerState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayerState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PlayerState()';
}


}

/// @nodoc
class $PlayerStateCopyWith<$Res>  {
$PlayerStateCopyWith(PlayerState _, $Res Function(PlayerState) __);
}


/// Adds pattern-matching-related methods to [PlayerState].
extension PlayerStatePatterns on PlayerState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( PlayerInitial value)?  initial,TResult Function( PlayerLoading value)?  loading,TResult Function( PlayerReady value)?  ready,TResult Function( PlayerFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case PlayerInitial() when initial != null:
return initial(_that);case PlayerLoading() when loading != null:
return loading(_that);case PlayerReady() when ready != null:
return ready(_that);case PlayerFailure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( PlayerInitial value)  initial,required TResult Function( PlayerLoading value)  loading,required TResult Function( PlayerReady value)  ready,required TResult Function( PlayerFailure value)  failure,}){
final _that = this;
switch (_that) {
case PlayerInitial():
return initial(_that);case PlayerLoading():
return loading(_that);case PlayerReady():
return ready(_that);case PlayerFailure():
return failure(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( PlayerInitial value)?  initial,TResult? Function( PlayerLoading value)?  loading,TResult? Function( PlayerReady value)?  ready,TResult? Function( PlayerFailure value)?  failure,}){
final _that = this;
switch (_that) {
case PlayerInitial() when initial != null:
return initial(_that);case PlayerLoading() when loading != null:
return loading(_that);case PlayerReady() when ready != null:
return ready(_that);case PlayerFailure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( String courseId,  String lessonId,  LocalizedTextModel lessonTitle,  LocalizedTextModel sectionTitle,  int lessonIndex,  int totalLessons,  LessonStatus status,  bool canGoNext,  Duration position,  Duration duration,  bool isPlaying,  double speed,  bool isCompleted,  String? nextLessonId,  VideoPlayerController? controller,  String? videoError)?  ready,TResult Function( String message)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case PlayerInitial() when initial != null:
return initial();case PlayerLoading() when loading != null:
return loading();case PlayerReady() when ready != null:
return ready(_that.courseId,_that.lessonId,_that.lessonTitle,_that.sectionTitle,_that.lessonIndex,_that.totalLessons,_that.status,_that.canGoNext,_that.position,_that.duration,_that.isPlaying,_that.speed,_that.isCompleted,_that.nextLessonId,_that.controller,_that.videoError);case PlayerFailure() when failure != null:
return failure(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( String courseId,  String lessonId,  LocalizedTextModel lessonTitle,  LocalizedTextModel sectionTitle,  int lessonIndex,  int totalLessons,  LessonStatus status,  bool canGoNext,  Duration position,  Duration duration,  bool isPlaying,  double speed,  bool isCompleted,  String? nextLessonId,  VideoPlayerController? controller,  String? videoError)  ready,required TResult Function( String message)  failure,}) {final _that = this;
switch (_that) {
case PlayerInitial():
return initial();case PlayerLoading():
return loading();case PlayerReady():
return ready(_that.courseId,_that.lessonId,_that.lessonTitle,_that.sectionTitle,_that.lessonIndex,_that.totalLessons,_that.status,_that.canGoNext,_that.position,_that.duration,_that.isPlaying,_that.speed,_that.isCompleted,_that.nextLessonId,_that.controller,_that.videoError);case PlayerFailure():
return failure(_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( String courseId,  String lessonId,  LocalizedTextModel lessonTitle,  LocalizedTextModel sectionTitle,  int lessonIndex,  int totalLessons,  LessonStatus status,  bool canGoNext,  Duration position,  Duration duration,  bool isPlaying,  double speed,  bool isCompleted,  String? nextLessonId,  VideoPlayerController? controller,  String? videoError)?  ready,TResult? Function( String message)?  failure,}) {final _that = this;
switch (_that) {
case PlayerInitial() when initial != null:
return initial();case PlayerLoading() when loading != null:
return loading();case PlayerReady() when ready != null:
return ready(_that.courseId,_that.lessonId,_that.lessonTitle,_that.sectionTitle,_that.lessonIndex,_that.totalLessons,_that.status,_that.canGoNext,_that.position,_that.duration,_that.isPlaying,_that.speed,_that.isCompleted,_that.nextLessonId,_that.controller,_that.videoError);case PlayerFailure() when failure != null:
return failure(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class PlayerInitial implements PlayerState {
  const PlayerInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayerInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PlayerState.initial()';
}


}




/// @nodoc


class PlayerLoading implements PlayerState {
  const PlayerLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayerLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PlayerState.loading()';
}


}




/// @nodoc


class PlayerReady implements PlayerState {
  const PlayerReady({required this.courseId, required this.lessonId, required this.lessonTitle, required this.sectionTitle, required this.lessonIndex, required this.totalLessons, required this.status, required this.canGoNext, required this.position, required this.duration, required this.isPlaying, required this.speed, required this.isCompleted, this.nextLessonId, this.controller, this.videoError});
  

 final  String courseId;
 final  String lessonId;
 final  LocalizedTextModel lessonTitle;
 final  LocalizedTextModel sectionTitle;
 final  int lessonIndex;
 final  int totalLessons;
 final  LessonStatus status;
 final  bool canGoNext;
 final  Duration position;
 final  Duration duration;
 final  bool isPlaying;
 final  double speed;
 final  bool isCompleted;
 final  String? nextLessonId;
 final  VideoPlayerController? controller;
 final  String? videoError;

/// Create a copy of PlayerState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayerReadyCopyWith<PlayerReady> get copyWith => _$PlayerReadyCopyWithImpl<PlayerReady>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayerReady&&(identical(other.courseId, courseId) || other.courseId == courseId)&&(identical(other.lessonId, lessonId) || other.lessonId == lessonId)&&(identical(other.lessonTitle, lessonTitle) || other.lessonTitle == lessonTitle)&&(identical(other.sectionTitle, sectionTitle) || other.sectionTitle == sectionTitle)&&(identical(other.lessonIndex, lessonIndex) || other.lessonIndex == lessonIndex)&&(identical(other.totalLessons, totalLessons) || other.totalLessons == totalLessons)&&(identical(other.status, status) || other.status == status)&&(identical(other.canGoNext, canGoNext) || other.canGoNext == canGoNext)&&(identical(other.position, position) || other.position == position)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.isPlaying, isPlaying) || other.isPlaying == isPlaying)&&(identical(other.speed, speed) || other.speed == speed)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.nextLessonId, nextLessonId) || other.nextLessonId == nextLessonId)&&(identical(other.controller, controller) || other.controller == controller)&&(identical(other.videoError, videoError) || other.videoError == videoError));
}


@override
int get hashCode => Object.hash(runtimeType,courseId,lessonId,lessonTitle,sectionTitle,lessonIndex,totalLessons,status,canGoNext,position,duration,isPlaying,speed,isCompleted,nextLessonId,controller,videoError);

@override
String toString() {
  return 'PlayerState.ready(courseId: $courseId, lessonId: $lessonId, lessonTitle: $lessonTitle, sectionTitle: $sectionTitle, lessonIndex: $lessonIndex, totalLessons: $totalLessons, status: $status, canGoNext: $canGoNext, position: $position, duration: $duration, isPlaying: $isPlaying, speed: $speed, isCompleted: $isCompleted, nextLessonId: $nextLessonId, controller: $controller, videoError: $videoError)';
}


}

/// @nodoc
abstract mixin class $PlayerReadyCopyWith<$Res> implements $PlayerStateCopyWith<$Res> {
  factory $PlayerReadyCopyWith(PlayerReady value, $Res Function(PlayerReady) _then) = _$PlayerReadyCopyWithImpl;
@useResult
$Res call({
 String courseId, String lessonId, LocalizedTextModel lessonTitle, LocalizedTextModel sectionTitle, int lessonIndex, int totalLessons, LessonStatus status, bool canGoNext, Duration position, Duration duration, bool isPlaying, double speed, bool isCompleted, String? nextLessonId, VideoPlayerController? controller, String? videoError
});


$LocalizedTextModelCopyWith<$Res> get lessonTitle;$LocalizedTextModelCopyWith<$Res> get sectionTitle;

}
/// @nodoc
class _$PlayerReadyCopyWithImpl<$Res>
    implements $PlayerReadyCopyWith<$Res> {
  _$PlayerReadyCopyWithImpl(this._self, this._then);

  final PlayerReady _self;
  final $Res Function(PlayerReady) _then;

/// Create a copy of PlayerState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? courseId = null,Object? lessonId = null,Object? lessonTitle = null,Object? sectionTitle = null,Object? lessonIndex = null,Object? totalLessons = null,Object? status = null,Object? canGoNext = null,Object? position = null,Object? duration = null,Object? isPlaying = null,Object? speed = null,Object? isCompleted = null,Object? nextLessonId = freezed,Object? controller = freezed,Object? videoError = freezed,}) {
  return _then(PlayerReady(
courseId: null == courseId ? _self.courseId : courseId // ignore: cast_nullable_to_non_nullable
as String,lessonId: null == lessonId ? _self.lessonId : lessonId // ignore: cast_nullable_to_non_nullable
as String,lessonTitle: null == lessonTitle ? _self.lessonTitle : lessonTitle // ignore: cast_nullable_to_non_nullable
as LocalizedTextModel,sectionTitle: null == sectionTitle ? _self.sectionTitle : sectionTitle // ignore: cast_nullable_to_non_nullable
as LocalizedTextModel,lessonIndex: null == lessonIndex ? _self.lessonIndex : lessonIndex // ignore: cast_nullable_to_non_nullable
as int,totalLessons: null == totalLessons ? _self.totalLessons : totalLessons // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LessonStatus,canGoNext: null == canGoNext ? _self.canGoNext : canGoNext // ignore: cast_nullable_to_non_nullable
as bool,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as Duration,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as Duration,isPlaying: null == isPlaying ? _self.isPlaying : isPlaying // ignore: cast_nullable_to_non_nullable
as bool,speed: null == speed ? _self.speed : speed // ignore: cast_nullable_to_non_nullable
as double,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,nextLessonId: freezed == nextLessonId ? _self.nextLessonId : nextLessonId // ignore: cast_nullable_to_non_nullable
as String?,controller: freezed == controller ? _self.controller : controller // ignore: cast_nullable_to_non_nullable
as VideoPlayerController?,videoError: freezed == videoError ? _self.videoError : videoError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of PlayerState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextModelCopyWith<$Res> get lessonTitle {
  
  return $LocalizedTextModelCopyWith<$Res>(_self.lessonTitle, (value) {
    return _then(_self.copyWith(lessonTitle: value));
  });
}/// Create a copy of PlayerState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextModelCopyWith<$Res> get sectionTitle {
  
  return $LocalizedTextModelCopyWith<$Res>(_self.sectionTitle, (value) {
    return _then(_self.copyWith(sectionTitle: value));
  });
}
}

/// @nodoc


class PlayerFailure implements PlayerState {
  const PlayerFailure(this.message);
  

 final  String message;

/// Create a copy of PlayerState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayerFailureCopyWith<PlayerFailure> get copyWith => _$PlayerFailureCopyWithImpl<PlayerFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayerFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'PlayerState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class $PlayerFailureCopyWith<$Res> implements $PlayerStateCopyWith<$Res> {
  factory $PlayerFailureCopyWith(PlayerFailure value, $Res Function(PlayerFailure) _then) = _$PlayerFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$PlayerFailureCopyWithImpl<$Res>
    implements $PlayerFailureCopyWith<$Res> {
  _$PlayerFailureCopyWithImpl(this._self, this._then);

  final PlayerFailure _self;
  final $Res Function(PlayerFailure) _then;

/// Create a copy of PlayerState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(PlayerFailure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
