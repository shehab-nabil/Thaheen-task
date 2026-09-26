// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LessonModel _$LessonModelFromJson(Map<String, dynamic> json) => _LessonModel(
  id: json['id'] as String,
  title: LocalizedTextModel.fromJson(json['title'] as Map<String, dynamic>),
  durationSec: (json['durationSec'] as num).toInt(),
  video: json['video'] as String,
);

Map<String, dynamic> _$LessonModelToJson(_LessonModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'durationSec': instance.durationSec,
      'video': instance.video,
    };
