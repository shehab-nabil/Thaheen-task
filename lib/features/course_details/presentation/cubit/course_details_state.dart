import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/shared/progress/domain/services/lesson_status.dart';
import '../../../courses/data/models/course_model.dart';
import '../../../courses/data/models/lesson_model.dart';

part 'course_details_state.freezed.dart';

/// The lesson the user tapped, and the lesson they must finish first to
/// unlock it. Held as a transient field on [CourseDetailsSuccess] rather
/// than a separate state, so the sheet is a one-off effect layered on top
/// of content that stays visible (see the [listenWhen] usage in the page).
typedef LockedLessonTap = ({LessonModel lesson, LessonModel requiredLesson});

@freezed
sealed class CourseDetailsState with _$CourseDetailsState {
  const factory CourseDetailsState.initial() = CourseDetailsInitial;

  const factory CourseDetailsState.loading() = CourseDetailsLoading;

  const factory CourseDetailsState.success({
    required CourseModel course,
    required List<LessonStatus> lessonStatuses,
    required int progressPercent,
    required int completedLessons,
    LessonModel? nextUnfinishedLesson,
    LockedLessonTap? lockedTap,
  }) = CourseDetailsSuccess;

  const factory CourseDetailsState.empty() = CourseDetailsEmpty;

  const factory CourseDetailsState.failure(String message) =
      CourseDetailsFailure;
}
