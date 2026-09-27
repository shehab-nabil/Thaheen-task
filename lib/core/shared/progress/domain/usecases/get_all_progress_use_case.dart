import 'package:dartz/dartz.dart';

import '../../../../errors/failures.dart';
import '../../data/models/lesson_progress_model.dart';
import '../repositories/progress_repository.dart';

class GetAllProgressUseCase {
  const GetAllProgressUseCase(this._repository);

  final ProgressRepository _repository;

  Future<Either<Failure, Map<String, LessonProgressModel>>> call() {
    return _repository.getAllProgress();
  }
}
