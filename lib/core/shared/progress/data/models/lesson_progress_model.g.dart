// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_progress_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LessonProgressModel _$LessonProgressModelFromJson(Map<String, dynamic> json) =>
    _LessonProgressModel(
      lessonId: json['lessonId'] as String,
      positionMs: (json['positionMs'] as num).toInt(),
      durationMs: (json['durationMs'] as num).toInt(),
      isCompleted: json['isCompleted'] as bool,
      updatedAt: (json['updatedAt'] as num).toInt(),
    );

Map<String, dynamic> _$LessonProgressModelToJson(
  _LessonProgressModel instance,
) => <String, dynamic>{
  'lessonId': instance.lessonId,
  'positionMs': instance.positionMs,
  'durationMs': instance.durationMs,
  'isCompleted': instance.isCompleted,
  'updatedAt': instance.updatedAt,
};
