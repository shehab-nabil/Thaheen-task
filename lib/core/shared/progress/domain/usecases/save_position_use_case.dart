import 'package:dartz/dartz.dart';

import '../../../../errors/failures.dart';
import '../../data/models/lesson_progress_model.dart';
import '../repositories/progress_repository.dart';

/// Persists the current playback position for a lesson. Completion is not
/// recomputed here: the existing `isCompleted` flag is carried over as-is,
/// since only [MarkCompletedUseCase] is allowed to flip it to true.
class SavePositionUseCase {
  const SavePositionUseCase(this._repository);

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
          isCompleted: existing?.isCompleted ?? false,
          updatedAt: DateTime.now().millisecondsSinceEpoch,
        );
        return _repository.saveProgress(updated);
      },
    );
  }
}
