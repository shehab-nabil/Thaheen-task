import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../generated/l10n.dart';
import '../../domain/repositories/courses_repository.dart';
import '../datasources/courses_local_data_source.dart';
import '../models/course_model.dart';

class CoursesRepositoryImpl implements CoursesRepository {
  const CoursesRepositoryImpl(this._localDataSource);

  final CoursesLocalDataSource _localDataSource;

  @override
  Future<Either<Failure, List<CourseModel>>> getCourses() async {
    try {
      final courses = await _localDataSource.getCourses();
      return Right(courses);
    } on FormatException {
      return Left(ParseFailure(S.current.courseParseFailure));
    } catch (_) {
      // Anything other than malformed JSON content is treated as the
      // asset itself failing to load (missing file, bundle error, etc).
      return Left(AssetFailure(S.current.courseAssetMissing));
    }
  }
}
