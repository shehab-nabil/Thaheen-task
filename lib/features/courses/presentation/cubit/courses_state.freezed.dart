// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'courses_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CoursesState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CoursesState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CoursesState()';
}


}

/// @nodoc
class $CoursesStateCopyWith<$Res>  {
$CoursesStateCopyWith(CoursesState _, $Res Function(CoursesState) __);
}


/// Adds pattern-matching-related methods to [CoursesState].
extension CoursesStatePatterns on CoursesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CoursesInitial value)?  initial,TResult Function( CoursesLoading value)?  loading,TResult Function( CoursesSuccess value)?  success,TResult Function( CoursesEmpty value)?  empty,TResult Function( CoursesFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CoursesInitial() when initial != null:
return initial(_that);case CoursesLoading() when loading != null:
return loading(_that);case CoursesSuccess() when success != null:
return success(_that);case CoursesEmpty() when empty != null:
return empty(_that);case CoursesFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CoursesInitial value)  initial,required TResult Function( CoursesLoading value)  loading,required TResult Function( CoursesSuccess value)  success,required TResult Function( CoursesEmpty value)  empty,required TResult Function( CoursesFailure value)  failure,}){
final _that = this;
switch (_that) {
case CoursesInitial():
return initial(_that);case CoursesLoading():
return loading(_that);case CoursesSuccess():
return success(_that);case CoursesEmpty():
return empty(_that);case CoursesFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CoursesInitial value)?  initial,TResult? Function( CoursesLoading value)?  loading,TResult? Function( CoursesSuccess value)?  success,TResult? Function( CoursesEmpty value)?  empty,TResult? Function( CoursesFailure value)?  failure,}){
final _that = this;
switch (_that) {
case CoursesInitial() when initial != null:
return initial(_that);case CoursesLoading() when loading != null:
return loading(_that);case CoursesSuccess() when success != null:
return success(_that);case CoursesEmpty() when empty != null:
return empty(_that);case CoursesFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<CourseModel> courses,  List<CourseModel> filteredCourses,  Map<String, int> progressPercentByCourseId,  ContinueWatchingModel? continueWatching,  String query)?  success,TResult Function()?  empty,TResult Function( String message)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CoursesInitial() when initial != null:
return initial();case CoursesLoading() when loading != null:
return loading();case CoursesSuccess() when success != null:
return success(_that.courses,_that.filteredCourses,_that.progressPercentByCourseId,_that.continueWatching,_that.query);case CoursesEmpty() when empty != null:
return empty();case CoursesFailure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<CourseModel> courses,  List<CourseModel> filteredCourses,  Map<String, int> progressPercentByCourseId,  ContinueWatchingModel? continueWatching,  String query)  success,required TResult Function()  empty,required TResult Function( String message)  failure,}) {final _that = this;
switch (_that) {
case CoursesInitial():
return initial();case CoursesLoading():
return loading();case CoursesSuccess():
return success(_that.courses,_that.filteredCourses,_that.progressPercentByCourseId,_that.continueWatching,_that.query);case CoursesEmpty():
return empty();case CoursesFailure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<CourseModel> courses,  List<CourseModel> filteredCourses,  Map<String, int> progressPercentByCourseId,  ContinueWatchingModel? continueWatching,  String query)?  success,TResult? Function()?  empty,TResult? Function( String message)?  failure,}) {final _that = this;
switch (_that) {
case CoursesInitial() when initial != null:
return initial();case CoursesLoading() when loading != null:
return loading();case CoursesSuccess() when success != null:
return success(_that.courses,_that.filteredCourses,_that.progressPercentByCourseId,_that.continueWatching,_that.query);case CoursesEmpty() when empty != null:
return empty();case CoursesFailure() when failure != null:
return failure(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class CoursesInitial implements CoursesState {
  const CoursesInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CoursesInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CoursesState.initial()';
}


}




/// @nodoc


class CoursesLoading implements CoursesState {
  const CoursesLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CoursesLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CoursesState.loading()';
}


}




/// @nodoc


class CoursesSuccess implements CoursesState {
  const CoursesSuccess({required final  List<CourseModel> courses, required final  List<CourseModel> filteredCourses, required final  Map<String, int> progressPercentByCourseId, this.continueWatching, this.query = ''}): _courses = courses,_filteredCourses = filteredCourses,_progressPercentByCourseId = progressPercentByCourseId;
  

 final  List<CourseModel> _courses;
 List<CourseModel> get courses {
  if (_courses is EqualUnmodifiableListView) return _courses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_courses);
}

 final  List<CourseModel> _filteredCourses;
 List<CourseModel> get filteredCourses {
  if (_filteredCourses is EqualUnmodifiableListView) return _filteredCourses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_filteredCourses);
}

 final  Map<String, int> _progressPercentByCourseId;
 Map<String, int> get progressPercentByCourseId {
  if (_progressPercentByCourseId is EqualUnmodifiableMapView) return _progressPercentByCourseId;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_progressPercentByCourseId);
}

 final  ContinueWatchingModel? continueWatching;
@JsonKey() final  String query;

/// Create a copy of CoursesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CoursesSuccessCopyWith<CoursesSuccess> get copyWith => _$CoursesSuccessCopyWithImpl<CoursesSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CoursesSuccess&&const DeepCollectionEquality().equals(other._courses, _courses)&&const DeepCollectionEquality().equals(other._filteredCourses, _filteredCourses)&&const DeepCollectionEquality().equals(other._progressPercentByCourseId, _progressPercentByCourseId)&&(identical(other.continueWatching, continueWatching) || other.continueWatching == continueWatching)&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_courses),const DeepCollectionEquality().hash(_filteredCourses),const DeepCollectionEquality().hash(_progressPercentByCourseId),continueWatching,query);

@override
String toString() {
  return 'CoursesState.success(courses: $courses, filteredCourses: $filteredCourses, progressPercentByCourseId: $progressPercentByCourseId, continueWatching: $continueWatching, query: $query)';
}


}

/// @nodoc
abstract mixin class $CoursesSuccessCopyWith<$Res> implements $CoursesStateCopyWith<$Res> {
  factory $CoursesSuccessCopyWith(CoursesSuccess value, $Res Function(CoursesSuccess) _then) = _$CoursesSuccessCopyWithImpl;
@useResult
$Res call({
 List<CourseModel> courses, List<CourseModel> filteredCourses, Map<String, int> progressPercentByCourseId, ContinueWatchingModel? continueWatching, String query
});


$ContinueWatchingModelCopyWith<$Res>? get continueWatching;

}
/// @nodoc
class _$CoursesSuccessCopyWithImpl<$Res>
    implements $CoursesSuccessCopyWith<$Res> {
  _$CoursesSuccessCopyWithImpl(this._self, this._then);

  final CoursesSuccess _self;
  final $Res Function(CoursesSuccess) _then;

/// Create a copy of CoursesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? courses = null,Object? filteredCourses = null,Object? progressPercentByCourseId = null,Object? continueWatching = freezed,Object? query = null,}) {
  return _then(CoursesSuccess(
courses: null == courses ? _self._courses : courses // ignore: cast_nullable_to_non_nullable
as List<CourseModel>,filteredCourses: null == filteredCourses ? _self._filteredCourses : filteredCourses // ignore: cast_nullable_to_non_nullable
as List<CourseModel>,progressPercentByCourseId: null == progressPercentByCourseId ? _self._progressPercentByCourseId : progressPercentByCourseId // ignore: cast_nullable_to_non_nullable
as Map<String, int>,continueWatching: freezed == continueWatching ? _self.continueWatching : continueWatching // ignore: cast_nullable_to_non_nullable
as ContinueWatchingModel?,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of CoursesState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ContinueWatchingModelCopyWith<$Res>? get continueWatching {
    if (_self.continueWatching == null) {
    return null;
  }

  return $ContinueWatchingModelCopyWith<$Res>(_self.continueWatching!, (value) {
    return _then(_self.copyWith(continueWatching: value));
  });
}
}

/// @nodoc


class CoursesEmpty implements CoursesState {
  const CoursesEmpty();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CoursesEmpty);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CoursesState.empty()';
}


}




/// @nodoc


class CoursesFailure implements CoursesState {
  const CoursesFailure(this.message);
  

 final  String message;

/// Create a copy of CoursesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CoursesFailureCopyWith<CoursesFailure> get copyWith => _$CoursesFailureCopyWithImpl<CoursesFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CoursesFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'CoursesState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class $CoursesFailureCopyWith<$Res> implements $CoursesStateCopyWith<$Res> {
  factory $CoursesFailureCopyWith(CoursesFailure value, $Res Function(CoursesFailure) _then) = _$CoursesFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$CoursesFailureCopyWithImpl<$Res>
    implements $CoursesFailureCopyWith<$Res> {
  _$CoursesFailureCopyWithImpl(this._self, this._then);

  final CoursesFailure _self;
  final $Res Function(CoursesFailure) _then;

/// Create a copy of CoursesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(CoursesFailure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
