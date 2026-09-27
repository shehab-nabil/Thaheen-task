import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../settings/data/models/localized_text_model.dart';
import 'lesson_model.dart';
import 'section_model.dart';

part 'course_model.freezed.dart';
part 'course_model.g.dart';

@freezed
abstract class CourseModel with _$CourseModel {
  const CourseModel._();

  const factory CourseModel({
    required String id,
    required LocalizedTextModel title,
    required LocalizedTextModel instructor,
    required String thumbnail,
    required List<SectionModel> sections,
  }) = _CourseModel;

  factory CourseModel.fromJson(Map<String, dynamic> json) =>
      _$CourseModelFromJson(json);

  /// All lessons across all sections, in course order. This flattened,
  /// globally-ordered list is what the unlock/completion rules operate on.
  List<LessonModel> get allLessons =>
      sections.expand((section) => section.lessons).toList();

  int get totalLessons => allLessons.length;

  /// Finds the section, lesson, and flattened (course-wide) index for
  /// [lessonId], or null if this course has no such lesson.
  ({SectionModel section, LessonModel lesson, int index})? locateLesson(
    String lessonId,
  ) {
    var index = 0;
    for (final section in sections) {
      for (final lesson in section.lessons) {
        if (lesson.id == lessonId) {
          return (section: section, lesson: lesson, index: index);
        }
        index++;
      }
    }
    return null;
  }
}
