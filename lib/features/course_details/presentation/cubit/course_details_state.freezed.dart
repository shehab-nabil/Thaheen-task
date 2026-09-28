// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'course_details_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CourseDetailsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CourseDetailsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CourseDetailsState()';
}


}

/// @nodoc
class $CourseDetailsStateCopyWith<$Res>  {
$CourseDetailsStateCopyWith(CourseDetailsState _, $Res Function(CourseDetailsState) __);
}


/// Adds pattern-matching-related methods to [CourseDetailsState].
extension CourseDetailsStatePatterns on CourseDetailsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CourseDetailsInitial value)?  initial,TResult Function( CourseDetailsLoading value)?  loading,TResult Function( CourseDetailsSuccess value)?  success,TResult Function( CourseDetailsEmpty value)?  empty,TResult Function( CourseDetailsFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CourseDetailsInitial() when initial != null:
return initial(_that);case CourseDetailsLoading() when loading != null:
return loading(_that);case CourseDetailsSuccess() when success != null:
return success(_that);case CourseDetailsEmpty() when empty != null:
return empty(_that);case CourseDetailsFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CourseDetailsInitial value)  initial,required TResult Function( CourseDetailsLoading value)  loading,required TResult Function( CourseDetailsSuccess value)  success,required TResult Function( CourseDetailsEmpty value)  empty,required TResult Function( CourseDetailsFailure value)  failure,}){
final _that = this;
switch (_that) {
case CourseDetailsInitial():
return initial(_that);case CourseDetailsLoading():
return loading(_that);case CourseDetailsSuccess():
return success(_that);case CourseDetailsEmpty():
return empty(_that);case CourseDetailsFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CourseDetailsInitial value)?  initial,TResult? Function( CourseDetailsLoading value)?  loading,TResult? Function( CourseDetailsSuccess value)?  success,TResult? Function( CourseDetailsEmpty value)?  empty,TResult? Function( CourseDetailsFailure value)?  failure,}){
final _that = this;
switch (_that) {
case CourseDetailsInitial() when initial != null:
return initial(_that);case CourseDetailsLoading() when loading != null:
return loading(_that);case CourseDetailsSuccess() when success != null:
return success(_that);case CourseDetailsEmpty() when empty != null:
return empty(_that);case CourseDetailsFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( CourseModel course,  List<LessonStatus> lessonStatuses,  List<int> lessonProgressPercent,  int progressPercent,  int completedLessons,  LessonModel? nextUnfinishedLesson,  LockedLessonTap? lockedTap)?  success,TResult Function()?  empty,TResult Function( String message)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CourseDetailsInitial() when initial != null:
return initial();case CourseDetailsLoading() when loading != null:
return loading();case CourseDetailsSuccess() when success != null:
return success(_that.course,_that.lessonStatuses,_that.lessonProgressPercent,_that.progressPercent,_that.completedLessons,_that.nextUnfinishedLesson,_that.lockedTap);case CourseDetailsEmpty() when empty != null:
return empty();case CourseDetailsFailure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( CourseModel course,  List<LessonStatus> lessonStatuses,  List<int> lessonProgressPercent,  int progressPercent,  int completedLessons,  LessonModel? nextUnfinishedLesson,  LockedLessonTap? lockedTap)  success,required TResult Function()  empty,required TResult Function( String message)  failure,}) {final _that = this;
switch (_that) {
case CourseDetailsInitial():
return initial();case CourseDetailsLoading():
return loading();case CourseDetailsSuccess():
return success(_that.course,_that.lessonStatuses,_that.lessonProgressPercent,_that.progressPercent,_that.completedLessons,_that.nextUnfinishedLesson,_that.lockedTap);case CourseDetailsEmpty():
return empty();case CourseDetailsFailure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( CourseModel course,  List<LessonStatus> lessonStatuses,  List<int> lessonProgressPercent,  int progressPercent,  int completedLessons,  LessonModel? nextUnfinishedLesson,  LockedLessonTap? lockedTap)?  success,TResult? Function()?  empty,TResult? Function( String message)?  failure,}) {final _that = this;
switch (_that) {
case CourseDetailsInitial() when initial != null:
return initial();case CourseDetailsLoading() when loading != null:
return loading();case CourseDetailsSuccess() when success != null:
return success(_that.course,_that.lessonStatuses,_that.lessonProgressPercent,_that.progressPercent,_that.completedLessons,_that.nextUnfinishedLesson,_that.lockedTap);case CourseDetailsEmpty() when empty != null:
return empty();case CourseDetailsFailure() when failure != null:
return failure(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class CourseDetailsInitial implements CourseDetailsState {
  const CourseDetailsInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CourseDetailsInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CourseDetailsState.initial()';
}


}




/// @nodoc


class CourseDetailsLoading implements CourseDetailsState {
  const CourseDetailsLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CourseDetailsLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CourseDetailsState.loading()';
}


}




/// @nodoc


class CourseDetailsSuccess implements CourseDetailsState {
  const CourseDetailsSuccess({required this.course, required final  List<LessonStatus> lessonStatuses, required final  List<int> lessonProgressPercent, required this.progressPercent, required this.completedLessons, this.nextUnfinishedLesson, this.lockedTap}): _lessonStatuses = lessonStatuses,_lessonProgressPercent = lessonProgressPercent;
  

 final  CourseModel course;
 final  List<LessonStatus> _lessonStatuses;
 List<LessonStatus> get lessonStatuses {
  if (_lessonStatuses is EqualUnmodifiableListView) return _lessonStatuses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lessonStatuses);
}

/// Parallel to [lessonStatuses]: each lesson's watched percent, used
/// for the in-progress mini progress bar on its tile.
 final  List<int> _lessonProgressPercent;
/// Parallel to [lessonStatuses]: each lesson's watched percent, used
/// for the in-progress mini progress bar on its tile.
 List<int> get lessonProgressPercent {
  if (_lessonProgressPercent is EqualUnmodifiableListView) return _lessonProgressPercent;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lessonProgressPercent);
}

 final  int progressPercent;
 final  int completedLessons;
 final  LessonModel? nextUnfinishedLesson;
 final  LockedLessonTap? lockedTap;

/// Create a copy of CourseDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CourseDetailsSuccessCopyWith<CourseDetailsSuccess> get copyWith => _$CourseDetailsSuccessCopyWithImpl<CourseDetailsSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CourseDetailsSuccess&&(identical(other.course, course) || other.course == course)&&const DeepCollectionEquality().equals(other._lessonStatuses, _lessonStatuses)&&const DeepCollectionEquality().equals(other._lessonProgressPercent, _lessonProgressPercent)&&(identical(other.progressPercent, progressPercent) || other.progressPercent == progressPercent)&&(identical(other.completedLessons, completedLessons) || other.completedLessons == completedLessons)&&(identical(other.nextUnfinishedLesson, nextUnfinishedLesson) || other.nextUnfinishedLesson == nextUnfinishedLesson)&&(identical(other.lockedTap, lockedTap) || other.lockedTap == lockedTap));
}


@override
int get hashCode => Object.hash(runtimeType,course,const DeepCollectionEquality().hash(_lessonStatuses),const DeepCollectionEquality().hash(_lessonProgressPercent),progressPercent,completedLessons,nextUnfinishedLesson,lockedTap);

@override
String toString() {
  return 'CourseDetailsState.success(course: $course, lessonStatuses: $lessonStatuses, lessonProgressPercent: $lessonProgressPercent, progressPercent: $progressPercent, completedLessons: $completedLessons, nextUnfinishedLesson: $nextUnfinishedLesson, lockedTap: $lockedTap)';
}


}

/// @nodoc
abstract mixin class $CourseDetailsSuccessCopyWith<$Res> implements $CourseDetailsStateCopyWith<$Res> {
  factory $CourseDetailsSuccessCopyWith(CourseDetailsSuccess value, $Res Function(CourseDetailsSuccess) _then) = _$CourseDetailsSuccessCopyWithImpl;
@useResult
$Res call({
 CourseModel course, List<LessonStatus> lessonStatuses, List<int> lessonProgressPercent, int progressPercent, int completedLessons, LessonModel? nextUnfinishedLesson, LockedLessonTap? lockedTap
});


$CourseModelCopyWith<$Res> get course;$LessonModelCopyWith<$Res>? get nextUnfinishedLesson;

}
/// @nodoc
class _$CourseDetailsSuccessCopyWithImpl<$Res>
    implements $CourseDetailsSuccessCopyWith<$Res> {
  _$CourseDetailsSuccessCopyWithImpl(this._self, this._then);

  final CourseDetailsSuccess _self;
  final $Res Function(CourseDetailsSuccess) _then;

/// Create a copy of CourseDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? course = null,Object? lessonStatuses = null,Object? lessonProgressPercent = null,Object? progressPercent = null,Object? completedLessons = null,Object? nextUnfinishedLesson = freezed,Object? lockedTap = freezed,}) {
  return _then(CourseDetailsSuccess(
course: null == course ? _self.course : course // ignore: cast_nullable_to_non_nullable
as CourseModel,lessonStatuses: null == lessonStatuses ? _self._lessonStatuses : lessonStatuses // ignore: cast_nullable_to_non_nullable
as List<LessonStatus>,lessonProgressPercent: null == lessonProgressPercent ? _self._lessonProgressPercent : lessonProgressPercent // ignore: cast_nullable_to_non_nullable
as List<int>,progressPercent: null == progressPercent ? _self.progressPercent : progressPercent // ignore: cast_nullable_to_non_nullable
as int,completedLessons: null == completedLessons ? _self.completedLessons : completedLessons // ignore: cast_nullable_to_non_nullable
as int,nextUnfinishedLesson: freezed == nextUnfinishedLesson ? _self.nextUnfinishedLesson : nextUnfinishedLesson // ignore: cast_nullable_to_non_nullable
as LessonModel?,lockedTap: freezed == lockedTap ? _self.lockedTap : lockedTap // ignore: cast_nullable_to_non_nullable
as LockedLessonTap?,
  ));
}

/// Create a copy of CourseDetailsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CourseModelCopyWith<$Res> get course {
  
  return $CourseModelCopyWith<$Res>(_self.course, (value) {
    return _then(_self.copyWith(course: value));
  });
}/// Create a copy of CourseDetailsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LessonModelCopyWith<$Res>? get nextUnfinishedLesson {
    if (_self.nextUnfinishedLesson == null) {
    return null;
  }

  return $LessonModelCopyWith<$Res>(_self.nextUnfinishedLesson!, (value) {
    return _then(_self.copyWith(nextUnfinishedLesson: value));
  });
}
}

/// @nodoc


class CourseDetailsEmpty implements CourseDetailsState {
  const CourseDetailsEmpty();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CourseDetailsEmpty);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CourseDetailsState.empty()';
}


}




/// @nodoc


class CourseDetailsFailure implements CourseDetailsState {
  const CourseDetailsFailure(this.message);
  

 final  String message;

/// Create a copy of CourseDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CourseDetailsFailureCopyWith<CourseDetailsFailure> get copyWith => _$CourseDetailsFailureCopyWithImpl<CourseDetailsFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CourseDetailsFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'CourseDetailsState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class $CourseDetailsFailureCopyWith<$Res> implements $CourseDetailsStateCopyWith<$Res> {
  factory $CourseDetailsFailureCopyWith(CourseDetailsFailure value, $Res Function(CourseDetailsFailure) _then) = _$CourseDetailsFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$CourseDetailsFailureCopyWithImpl<$Res>
    implements $CourseDetailsFailureCopyWith<$Res> {
  _$CourseDetailsFailureCopyWithImpl(this._self, this._then);

  final CourseDetailsFailure _self;
  final $Res Function(CourseDetailsFailure) _then;

/// Create a copy of CourseDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(CourseDetailsFailure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
