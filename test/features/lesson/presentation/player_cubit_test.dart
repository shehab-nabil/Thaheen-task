import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:thaheen_task/core/errors/failures.dart';
import 'package:thaheen_task/core/shared/progress/domain/services/progress_calculator.dart';
import 'package:thaheen_task/core/shared/progress/domain/usecases/mark_completed_use_case.dart';
import 'package:thaheen_task/core/shared/progress/domain/usecases/save_position_use_case.dart';
import 'package:thaheen_task/features/lesson/domain/usecases/get_lesson_playback_data_use_case.dart';
import 'package:thaheen_task/features/lesson/presentation/cubit/player_cubit.dart';
import 'package:thaheen_task/features/lesson/presentation/cubit/player_state.dart';

class MockGetLessonPlaybackDataUseCase extends Mock
    implements GetLessonPlaybackDataUseCase {}

class MockSavePositionUseCase extends Mock implements SavePositionUseCase {}

class MockMarkCompletedUseCase extends Mock implements MarkCompletedUseCase {}

void main() {
  late MockGetLessonPlaybackDataUseCase getLessonPlaybackDataUseCase;
  late MockSavePositionUseCase savePositionUseCase;
  late MockMarkCompletedUseCase markCompletedUseCase;

  setUp(() {
    getLessonPlaybackDataUseCase = MockGetLessonPlaybackDataUseCase();
    savePositionUseCase = MockSavePositionUseCase();
    markCompletedUseCase = MockMarkCompletedUseCase();
  });

  PlayerCubit buildCubit() {
    return PlayerCubit(
      getLessonPlaybackDataUseCase,
      savePositionUseCase,
      markCompletedUseCase,
      const ProgressCalculator(),
    );
  }

  // Note: the success path creates a real VideoPlayerController, which
  // needs a platform channel and isn't exercised here; see README for why
  // that's covered by manual/integration testing instead of a unit test.
  group('loadLesson', () {
    blocTest<PlayerCubit, PlayerState>(
      'emits [loading, failure] when the lesson lookup fails',
      setUp: () {
        when(
          () => getLessonPlaybackDataUseCase(
            courseId: 'anatomy-101',
            lessonId: 'missing',
          ),
        ).thenAnswer((_) async => const Left(ParseFailure('not found')));
      },
      build: buildCubit,
      act: (cubit) => cubit.loadLesson(
        courseId: 'anatomy-101',
        lessonId: 'missing',
        initialSpeed: 1,
      ),
      expect: () => [
        const PlayerState.loading(),
        const PlayerState.failure('not found'),
      ],
    );
  });
}
