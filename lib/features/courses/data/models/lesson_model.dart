import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../settings/data/models/localized_text_model.dart';

part 'lesson_model.freezed.dart';
part 'lesson_model.g.dart';

@freezed
abstract class LessonModel with _$LessonModel {
  const factory LessonModel({
    required String id,
    required LocalizedTextModel title,
    required int durationSec,
    required String video,
  }) = _LessonModel;

  factory LessonModel.fromJson(Map<String, dynamic> json) =>
      _$LessonModelFromJson(json);
}
