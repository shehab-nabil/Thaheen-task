import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../data/models/course_model.dart';

abstract class CoursesRepository {
  Future<Either<Failure, List<CourseModel>>> getCourses();
}
