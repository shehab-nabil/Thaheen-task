import 'package:freezed_annotation/freezed_annotation.dart';

part 'lesson_progress_model.freezed.dart';
part 'lesson_progress_model.g.dart';

@freezed
abstract class LessonProgressModel with _$LessonProgressModel {
  const factory LessonProgressModel({
    required String lessonId,
    required int positionMs,
    required int durationMs,
    required bool isCompleted,
    required int updatedAt,
  }) = _LessonProgressModel;

  factory LessonProgressModel.fromJson(Map<String, dynamic> json) =>
      _$LessonProgressModelFromJson(json);
}
