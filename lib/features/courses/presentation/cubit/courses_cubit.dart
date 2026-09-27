import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/shared/progress/data/models/lesson_progress_model.dart';
import '../../../../core/shared/progress/domain/services/progress_calculator.dart';
import '../../../../core/shared/progress/domain/usecases/get_all_progress_use_case.dart';
import '../../data/models/continue_watching_model.dart';
import '../../data/models/course_model.dart';
import '../../domain/usecases/get_courses_use_case.dart';
import 'courses_state.dart';

class CoursesCubit extends Cubit<CoursesState> {
  CoursesCubit(
    this._getCoursesUseCase,
    this._getAllProgressUseCase,
    this._calculator,
  ) : super(const CoursesState.initial());

  final GetCoursesUseCase _getCoursesUseCase;
  final GetAllProgressUseCase _getAllProgressUseCase;
  final ProgressCalculator _calculator;

  Future<void> loadCourses() async {
    if (state is CoursesLoading) return;
    emit(const CoursesState.loading());

    final coursesResult = await _getCoursesUseCase();
    if (isClosed) return;

    await coursesResult.fold(
      (failure) async => emit(CoursesState.failure(failure.message)),
      (courses) async {
        final progressResult = await _getAllProgressUseCase();
        if (isClosed) return;
        progressResult.fold(
          (failure) => emit(CoursesState.failure(failure.message)),
          (progressByLessonId) => _emitLoaded(courses, progressByLessonId),
        );
      },
    );
  }

  /// Filters the already-loaded courses by title/instructor in
  /// [languageCode]. No-op unless courses are already loaded; progress
  /// figures and the continue-watching card are unaffected by search.
  void search(String query, String languageCode) {
    final current = state;
    if (current is! CoursesSuccess) return;

    if (query.isEmpty) {
      emit(current.copyWith(filteredCourses: current.courses, query: query));
      return;
    }

    final lowerQuery = query.toLowerCase();
    final filtered = current.courses.where((course) {
      final title = course.title.resolve(languageCode).toLowerCase();
      final instructor = course.instructor.resolve(languageCode).toLowerCase();
      return title.contains(lowerQuery) || instructor.contains(lowerQuery);
    }).toList();

    emit(current.copyWith(filteredCourses: filtered, query: query));
  }

  void _emitLoaded(
    List<CourseModel> courses,
    Map<String, LessonProgressModel> progressByLessonId,
  ) {
    if (courses.isEmpty) {
      emit(const CoursesState.empty());
      return;
    }

    final progressPercentByCourseId = <String, int>{
      for (final course in courses)
        course.id: _calculator.courseProgressPercent(
          lessonIds: course.allLessons.map((lesson) => lesson.id).toList(),
          progressByLessonId: progressByLessonId,
        ),
    };

    final continueWatching = _buildContinueWatching(courses, progressByLessonId);

    emit(
      CoursesState.success(
        courses: courses,
        filteredCourses: courses,
        progressPercentByCourseId: progressPercentByCourseId,
        continueWatching: continueWatching,
      ),
    );
  }

  ContinueWatchingModel? _buildContinueWatching(
    List<CourseModel> courses,
    Map<String, LessonProgressModel> progressByLessonId,
  ) {
    final lessonIdsByCourseId = <String, List<String>>{
      for (final course in courses)
        course.id: course.allLessons.map((lesson) => lesson.id).toList(),
    };

    final lessonId = _calculator.findContinueWatchingLessonId(
      lessonIdsByCourseId: lessonIdsByCourseId,
      progressByLessonId: progressByLessonId,
    );
    if (lessonId == null) return null;

    for (final course in courses) {
      final located = course.locateLesson(lessonId);
      if (located == null) continue;
      final progress = progressByLessonId[lessonId];
      if (progress == null) continue;
      return ContinueWatchingModel(
        courseId: course.id,
        lessonId: lessonId,
        courseTitle: course.title,
        sectionTitle: located.section.title,
        lessonTitle: located.lesson.title,
        lessonIndex: located.index,
        totalLessons: course.totalLessons,
        positionMs: progress.positionMs,
        durationMs: progress.durationMs,
      );
    }
    return null;
  }
}
