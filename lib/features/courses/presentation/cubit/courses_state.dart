import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/continue_watching_model.dart';
import '../../data/models/course_model.dart';

part 'courses_state.freezed.dart';

@freezed
sealed class CoursesState with _$CoursesState {
  const factory CoursesState.initial() = CoursesInitial;

  const factory CoursesState.loading() = CoursesLoading;

  const factory CoursesState.success({
    required List<CourseModel> courses,
    required List<CourseModel> filteredCourses,
    required Map<String, int> progressPercentByCourseId,
    ContinueWatchingModel? continueWatching,
    @Default('') String query,
  }) = CoursesSuccess;

  const factory CoursesState.empty() = CoursesEmpty;

  const factory CoursesState.failure(String message) = CoursesFailure;
}
