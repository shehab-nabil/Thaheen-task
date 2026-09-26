// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'section_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SectionModel {

 String get id; LocalizedTextModel get title; List<LessonModel> get lessons;
/// Create a copy of SectionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SectionModelCopyWith<SectionModel> get copyWith => _$SectionModelCopyWithImpl<SectionModel>(this as SectionModel, _$identity);

  /// Serializes this SectionModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SectionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.lessons, lessons));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,const DeepCollectionEquality().hash(lessons));

@override
String toString() {
  return 'SectionModel(id: $id, title: $title, lessons: $lessons)';
}


}

/// @nodoc
abstract mixin class $SectionModelCopyWith<$Res>  {
  factory $SectionModelCopyWith(SectionModel value, $Res Function(SectionModel) _then) = _$SectionModelCopyWithImpl;
@useResult
$Res call({
 String id, LocalizedTextModel title, List<LessonModel> lessons
});


$LocalizedTextModelCopyWith<$Res> get title;

}
/// @nodoc
class _$SectionModelCopyWithImpl<$Res>
    implements $SectionModelCopyWith<$Res> {
  _$SectionModelCopyWithImpl(this._self, this._then);

  final SectionModel _self;
  final $Res Function(SectionModel) _then;

/// Create a copy of SectionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? lessons = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedTextModel,lessons: null == lessons ? _self.lessons : lessons // ignore: cast_nullable_to_non_nullable
as List<LessonModel>,
  ));
}
/// Create a copy of SectionModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextModelCopyWith<$Res> get title {
  
  return $LocalizedTextModelCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}
}


/// Adds pattern-matching-related methods to [SectionModel].
extension SectionModelPatterns on SectionModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SectionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SectionModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SectionModel value)  $default,){
final _that = this;
switch (_that) {
case _SectionModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SectionModel value)?  $default,){
final _that = this;
switch (_that) {
case _SectionModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  LocalizedTextModel title,  List<LessonModel> lessons)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SectionModel() when $default != null:
return $default(_that.id,_that.title,_that.lessons);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  LocalizedTextModel title,  List<LessonModel> lessons)  $default,) {final _that = this;
switch (_that) {
case _SectionModel():
return $default(_that.id,_that.title,_that.lessons);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  LocalizedTextModel title,  List<LessonModel> lessons)?  $default,) {final _that = this;
switch (_that) {
case _SectionModel() when $default != null:
return $default(_that.id,_that.title,_that.lessons);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SectionModel implements SectionModel {
  const _SectionModel({required this.id, required this.title, required final  List<LessonModel> lessons}): _lessons = lessons;
  factory _SectionModel.fromJson(Map<String, dynamic> json) => _$SectionModelFromJson(json);

@override final  String id;
@override final  LocalizedTextModel title;
 final  List<LessonModel> _lessons;
@override List<LessonModel> get lessons {
  if (_lessons is EqualUnmodifiableListView) return _lessons;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lessons);
}


/// Create a copy of SectionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SectionModelCopyWith<_SectionModel> get copyWith => __$SectionModelCopyWithImpl<_SectionModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SectionModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SectionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._lessons, _lessons));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,const DeepCollectionEquality().hash(_lessons));

@override
String toString() {
  return 'SectionModel(id: $id, title: $title, lessons: $lessons)';
}


}

/// @nodoc
abstract mixin class _$SectionModelCopyWith<$Res> implements $SectionModelCopyWith<$Res> {
  factory _$SectionModelCopyWith(_SectionModel value, $Res Function(_SectionModel) _then) = __$SectionModelCopyWithImpl;
@override @useResult
$Res call({
 String id, LocalizedTextModel title, List<LessonModel> lessons
});


@override $LocalizedTextModelCopyWith<$Res> get title;

}
/// @nodoc
class __$SectionModelCopyWithImpl<$Res>
    implements _$SectionModelCopyWith<$Res> {
  __$SectionModelCopyWithImpl(this._self, this._then);

  final _SectionModel _self;
  final $Res Function(_SectionModel) _then;

/// Create a copy of SectionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? lessons = null,}) {
  return _then(_SectionModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedTextModel,lessons: null == lessons ? _self._lessons : lessons // ignore: cast_nullable_to_non_nullable
as List<LessonModel>,
  ));
}

/// Create a copy of SectionModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextModelCopyWith<$Res> get title {
  
  return $LocalizedTextModelCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}
}

// dart format on
