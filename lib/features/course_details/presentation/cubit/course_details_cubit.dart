import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/shared/progress/data/models/lesson_progress_model.dart';
import '../../../../core/shared/progress/domain/services/lesson_status.dart';
import '../../../../core/shared/progress/domain/services/progress_calculator.dart';
import '../../../../core/shared/progress/domain/usecases/get_all_progress_use_case.dart';
import '../../../courses/data/models/course_model.dart';
import '../../../courses/data/models/lesson_model.dart';
import '../../domain/usecases/get_course_by_id_use_case.dart';
import 'course_details_state.dart';

class CourseDetailsCubit extends Cubit<CourseDetailsState> {
  CourseDetailsCubit(
    this._getCourseByIdUseCase,
    this._getAllProgressUseCase,
    this._calculator,
  ) : super(const CourseDetailsState.initial());

  final GetCourseByIdUseCase _getCourseByIdUseCase;
  final GetAllProgressUseCase _getAllProgressUseCase;
  final ProgressCalculator _calculator;

  Future<void> loadCourse(String courseId) async {
    if (state is CourseDetailsLoading) return;
    emit(const CourseDetailsState.loading());

    final courseResult = await _getCourseByIdUseCase(courseId);
    if (isClosed) return;

    await courseResult.fold(
      (failure) async => emit(CourseDetailsState.failure(failure.message)),
      (course) async {
        final progressResult = await _getAllProgressUseCase();
        if (isClosed) return;
        progressResult.fold(
          (failure) => emit(CourseDetailsState.failure(failure.message)),
          (progressByLessonId) => _emitLoaded(course, progressByLessonId),
        );
      },
    );
  }

  /// Called when the user taps a lesson. If it's locked, surfaces the
  /// locked-lesson-tap effect for the page to show as a modal sheet;
  /// otherwise does nothing (the caller navigates directly to the lesson).
  void onLessonTapped(LessonModel lesson) {
    final current = state;
    if (current is! CourseDetailsSuccess) return;

    final lessons = current.course.allLessons;
    final index = lessons.indexWhere((item) => item.id == lesson.id);
    if (index == -1) return;
    if (current.lessonStatuses[index] != LessonStatus.locked) return;

    // The immediate previous lesson may itself be locked (several lessons
    // in a row can be incomplete), so the lesson to actually finish next is
    // always the first unfinished one overall, not just index - 1.
    final requiredLesson = current.nextUnfinishedLesson;
    if (requiredLesson == null) return;

    emit(
      current.copyWith(
        lockedTap: (lesson: lesson, requiredLesson: requiredLesson),
      ),
    );
  }

  /// Clears the locked-lesson-tap effect once the page has shown it.
  void clearLockedTap() {
    final current = state;
    if (current is! CourseDetailsSuccess) return;
    emit(current.copyWith(lockedTap: null));
  }

  void _emitLoaded(
    CourseModel course,
    Map<String, LessonProgressModel> progressByLessonId,
  ) {
    final lessons = course.allLessons;
    if (lessons.isEmpty) {
      emit(const CourseDetailsState.empty());
      return;
    }

    final lessonIds = lessons.map((lesson) => lesson.id).toList();
    final statuses = _calculator.statusesFor(
      lessonIds: lessonIds,
      progressByLessonId: progressByLessonId,
    );
    final percent = _calculator.courseProgressPercent(
      lessonIds: lessonIds,
      progressByLessonId: progressByLessonId,
    );
    final completedCount =
        statuses.where((status) => status == LessonStatus.completed).length;

    LessonModel? nextUnfinished;
    for (var i = 0; i < lessons.length; i++) {
      if (statuses[i] != LessonStatus.completed) {
        nextUnfinished = lessons[i];
        break;
      }
    }

    emit(
      CourseDetailsState.success(
        course: course,
        lessonStatuses: statuses,
        progressPercent: percent,
        completedLessons: completedCount,
        nextUnfinishedLesson: nextUnfinished,
      ),
    );
  }
}
