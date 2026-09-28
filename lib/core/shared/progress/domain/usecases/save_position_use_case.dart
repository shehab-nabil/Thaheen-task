import 'package:dartz/dartz.dart';

import '../../../../errors/failures.dart';
import '../../data/models/lesson_progress_model.dart';
import '../repositories/progress_repository.dart';

/// Persists the current playback position for a lesson. Completion isn't
/// recomputed from position here: the caller passes [isCompletedHint] (its
/// own already-known completion state) which is OR'd with whatever is
/// currently stored. This makes the write safe even if it races a
/// concurrent [MarkCompletedUseCase] write for the same lesson and reads a
/// stale (still-false) `isCompleted` from storage: the hint keeps it from
/// ever regressing a real completion back to false.
class SavePositionUseCase {
  const SavePositionUseCase(this._repository);

  final ProgressRepository _repository;

  Future<Either<Failure, Unit>> call({
    required String lessonId,
    required int positionMs,
    required int durationMs,
    required bool isCompletedHint,
  }) async {
    final existingResult = await _repository.getProgress(lessonId);
    return existingResult.fold((failure) async => Left(failure), (existing) {
      final updated = LessonProgressModel(
        lessonId: lessonId,
        positionMs: positionMs,
        durationMs: durationMs,
        isCompleted: (existing?.isCompleted ?? false) || isCompletedHint,
        updatedAt: DateTime.now().millisecondsSinceEpoch,
      );
      return _repository.saveProgress(updated);
    });
  }
}
