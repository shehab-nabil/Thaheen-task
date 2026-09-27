import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../generated/l10n.dart';
import '../../../courses/data/models/course_model.dart';
import '../../../courses/domain/repositories/courses_repository.dart';

class GetCourseByIdUseCase {
  const GetCourseByIdUseCase(this._repository);

  final CoursesRepository _repository;

  Future<Either<Failure, CourseModel>> call(String courseId) async {
    final result = await _repository.getCourses();
    return result.fold(
      Left.new,
      (courses) {
        final matches = courses.where((course) => course.id == courseId);
        if (matches.isEmpty) {
          return Left(ParseFailure(S.current.courseNotFound));
        }
        return Right(matches.first);
      },
    );
  }
}
