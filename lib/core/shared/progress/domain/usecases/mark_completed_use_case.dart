import 'package:dartz/dartz.dart';

import '../../../../errors/failures.dart';
import '../../data/models/lesson_progress_model.dart';
import '../repositories/progress_repository.dart';

/// Flips a lesson's `isCompleted` flag to true. The caller (PlayerCubit) is
/// responsible for deciding *when* the 99% threshold has been crossed via
/// [ProgressCalculator.isCompleted]; this use case only performs the write.
class MarkCompletedUseCase {
  const MarkCompletedUseCase(this._repository);

  final ProgressRepository _repository;

  Future<Either<Failure, Unit>> call({
    required String lessonId,
    required int positionMs,
    required int durationMs,
  }) async {
    final existingResult = await _repository.getProgress(lessonId);
    return existingResult.fold(
      (failure) async => Left(failure),
      (existing) {
        final updated = LessonProgressModel(
          lessonId: lessonId,
          positionMs: positionMs,
          durationMs: durationMs,
          isCompleted: true,
          updatedAt: DateTime.now().millisecondsSinceEpoch,
        );
        return _repository.saveProgress(updated);
      },
    );
  }
}
