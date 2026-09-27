import 'package:dartz/dartz.dart';

import '../../../../errors/failures.dart';
import '../../data/models/lesson_progress_model.dart';

abstract class ProgressRepository {
  Future<Either<Failure, Map<String, LessonProgressModel>>> getAllProgress();
  Future<Either<Failure, LessonProgressModel?>> getProgress(String lessonId);
  Future<Either<Failure, Unit>> saveProgress(LessonProgressModel progress);
}
