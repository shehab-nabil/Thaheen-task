import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../settings/data/models/localized_text_model.dart';
import 'lesson_model.dart';

part 'section_model.freezed.dart';
part 'section_model.g.dart';

@freezed
abstract class SectionModel with _$SectionModel {
  const factory SectionModel({
    required String id,
    required LocalizedTextModel title,
    required List<LessonModel> lessons,
  }) = _SectionModel;

  factory SectionModel.fromJson(Map<String, dynamic> json) =>
      _$SectionModelFromJson(json);
}
