import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/shared/progress/data/models/lesson_progress_model.dart';
import '../../../../core/shared/progress/domain/repositories/progress_repository.dart';
import '../../../../generated/l10n.dart';
import '../../../courses/data/models/course_model.dart';
import '../../../courses/data/models/lesson_model.dart';
import '../../../courses/data/models/section_model.dart';
import '../../../courses/domain/repositories/courses_repository.dart';

/// Everything the lesson player needs to initialize: where the lesson sits
/// within its course, and the current progress state for the whole course.
typedef LessonPlaybackData = ({
  CourseModel course,
  SectionModel section,
  LessonModel lesson,
  int lessonIndex,
  List<String> lessonIdsInOrder,
  LessonProgressModel? progress,
  Map<String, LessonProgressModel> progressByLessonId,
});

class GetLessonPlaybackDataUseCase {
  const GetLessonPlaybackDataUseCase(
    this._coursesRepository,
    this._progressRepository,
  );

  final CoursesRepository _coursesRepository;
  final ProgressRepository _progressRepository;

  Future<Either<Failure, LessonPlaybackData>> call({
    required String courseId,
    required String lessonId,
  }) async {
    final coursesResult = await _coursesRepository.getCourses();
    return coursesResult.fold(
      (failure) async => Left(failure),
      (courses) async {
        final courseMatches = courses.where((course) => course.id == courseId);
        if (courseMatches.isEmpty) {
          return Left(ParseFailure(S.current.courseNotFound));
        }
        final course = courseMatches.first;

        final located = course.locateLesson(lessonId);
        if (located == null) {
          return Left(ParseFailure(S.current.courseNotFound));
        }

        final lessonIdsInOrder =
            course.allLessons.map((item) => item.id).toList();

        final progressResult = await _progressRepository.getAllProgress();
        return progressResult.fold(
          Left.new,
          (progressByLessonId) => Right((
            course: course,
            section: located.section,
            lesson: located.lesson,
            lessonIndex: located.index,
            lessonIdsInOrder: lessonIdsInOrder,
            progress: progressByLessonId[lessonId],
            progressByLessonId: progressByLessonId,
          )),
        );
      },
    );
  }
}
