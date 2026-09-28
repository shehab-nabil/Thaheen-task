import 'package:dartz/dartz.dart';

import '../../../../errors/failures.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/repositories/progress_repository.dart';
import '../datasources/progress_local_data_source.dart';
import '../models/lesson_progress_model.dart';

class ProgressRepositoryImpl implements ProgressRepository {
  const ProgressRepositoryImpl(this._localDataSource);

  final ProgressLocalDataSource _localDataSource;

  @override
  Future<Either<Failure, Map<String, LessonProgressModel>>>
  getAllProgress() async {
    try {
      return Right(_localDataSource.getAll());
    } catch (_) {
      return Left(CacheFailure(S.current.progressCacheFailure));
    }
  }

  @override
  Future<Either<Failure, LessonProgressModel?>> getProgress(
    String lessonId,
  ) async {
    try {
      return Right(_localDataSource.get(lessonId));
    } catch (_) {
      return Left(CacheFailure(S.current.progressCacheFailure));
    }
  }

  @override
  Future<Either<Failure, Unit>> saveProgress(
    LessonProgressModel progress,
  ) async {
    try {
      await _localDataSource.save(progress);
      return const Right(unit);
    } catch (_) {
      return Left(CacheFailure(S.current.progressCacheFailure));
    }
  }
}
