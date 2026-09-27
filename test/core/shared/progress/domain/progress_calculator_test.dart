import 'package:flutter_test/flutter_test.dart';
import 'package:thaheen_task/core/shared/progress/data/models/lesson_progress_model.dart';
import 'package:thaheen_task/core/shared/progress/domain/services/lesson_status.dart';
import 'package:thaheen_task/core/shared/progress/domain/services/progress_calculator.dart';

void main() {
  final calculator = const ProgressCalculator();

  LessonProgressModel progress({
    required String lessonId,
    int positionMs = 0,
    int durationMs = 100000,
    bool isCompleted = false,
    int updatedAt = 0,
  }) {
    return LessonProgressModel(
      lessonId: lessonId,
      positionMs: positionMs,
      durationMs: durationMs,
      isCompleted: isCompleted,
      updatedAt: updatedAt,
    );
  }

  group('isCompleted', () {
    test('89.9% watched is not completed', () {
      expect(
        calculator.isCompleted(positionMs: 89900, durationMs: 100000),
        isFalse,
      );
    });

    test('exactly 99% watched is completed', () {
      expect(
        calculator.isCompleted(positionMs: 99000, durationMs: 100000),
        isTrue,
      );
    });

    test('98.9% watched is not completed', () {
      expect(
        calculator.isCompleted(positionMs: 98900, durationMs: 100000),
        isFalse,
      );
    });

    test('zero duration never completes', () {
      expect(calculator.isCompleted(positionMs: 0, durationMs: 0), isFalse);
    });
  });

  group('isCompletedGiven (monotonic completion)', () {
    test('stays completed even if new position is below the threshold', () {
      final result = calculator.isCompletedGiven(
        wasCompleted: true,
        positionMs: 1000,
        durationMs: 100000,
      );
      expect(result, isTrue);
    });

    test('becomes completed once the threshold is reached', () {
      final result = calculator.isCompletedGiven(
        wasCompleted: false,
        positionMs: 99000,
        durationMs: 100000,
      );
      expect(result, isTrue);
    });

    test('remains not completed below the threshold', () {
      final result = calculator.isCompletedGiven(
        wasCompleted: false,
        positionMs: 50000,
        durationMs: 100000,
      );
      expect(result, isFalse);
    });
  });

  group('statusesFor (sequential unlock)', () {
    test('first lesson is always unlocked when there is no progress', () {
      final statuses = calculator.statusesFor(
        lessonIds: const ['l1', 'l2', 'l3'],
        progressByLessonId: const {},
      );
      expect(statuses[0], LessonStatus.notStarted);
    });

    test('next lesson stays locked until the previous one is completed', () {
      final statuses = calculator.statusesFor(
        lessonIds: const ['l1', 'l2', 'l3'],
        progressByLessonId: {
          'l1': progress(lessonId: 'l1', positionMs: 500, isCompleted: false),
        },
      );
      expect(statuses[0], LessonStatus.inProgress);
      expect(statuses[1], LessonStatus.locked);
      expect(statuses[2], LessonStatus.locked);
    });

    test('unlock works across a section boundary', () {
      // l1, l2 belong to section A; l3, l4 belong to section B. The
      // calculator only sees a flattened order, so completing l2 (the
      // last lesson of section A) must unlock l3 (the first of section B).
      final statuses = calculator.statusesFor(
        lessonIds: const ['l1', 'l2', 'l3', 'l4'],
        progressByLessonId: {
          'l1': progress(lessonId: 'l1', isCompleted: true),
          'l2': progress(lessonId: 'l2', isCompleted: true),
        },
      );
      expect(statuses[2], LessonStatus.notStarted);
      expect(statuses[3], LessonStatus.locked);
    });

    test('a completed lesson reports as completed regardless of position', () {
      final statuses = calculator.statusesFor(
        lessonIds: const ['l1'],
        progressByLessonId: {
          'l1': progress(lessonId: 'l1', isCompleted: true),
        },
      );
      expect(statuses[0], LessonStatus.completed);
    });
  });

  group('courseProgressPercent', () {
    test('0 of 5 completed is 0%', () {
      final percent = calculator.courseProgressPercent(
        lessonIds: const ['l1', 'l2', 'l3', 'l4', 'l5'],
        progressByLessonId: const {},
      );
      expect(percent, 0);
    });

    test('2 of 5 completed is 40%', () {
      final percent = calculator.courseProgressPercent(
        lessonIds: const ['l1', 'l2', 'l3', 'l4', 'l5'],
        progressByLessonId: {
          'l1': progress(lessonId: 'l1', isCompleted: true),
          'l2': progress(lessonId: 'l2', isCompleted: true),
        },
      );
      expect(percent, 40);
    });

    test('5 of 5 completed is 100%', () {
      final progressMap = {
        for (final id in ['l1', 'l2', 'l3', 'l4', 'l5'])
          id: progress(lessonId: id, isCompleted: true),
      };
      final percent = calculator.courseProgressPercent(
        lessonIds: const ['l1', 'l2', 'l3', 'l4', 'l5'],
        progressByLessonId: progressMap,
      );
      expect(percent, 100);
    });

    test('a course with no lessons is 0% (no division by zero)', () {
      final percent = calculator.courseProgressPercent(
        lessonIds: const [],
        progressByLessonId: const {},
      );
      expect(percent, 0);
    });
  });

  group('findContinueWatchingLessonId', () {
    test('picks the latest updated in-progress lesson across courses', () {
      final lessonId = calculator.findContinueWatchingLessonId(
        lessonIdsByCourseId: const {
          'course-a': ['a1', 'a2'],
          'course-b': ['b1', 'b2'],
        },
        progressByLessonId: {
          'a1': progress(lessonId: 'a1', positionMs: 100, updatedAt: 1000),
          'b1': progress(lessonId: 'b1', positionMs: 200, updatedAt: 5000),
        },
      );
      expect(lessonId, 'b1');
    });

    test('returns null when there is no in-progress lesson', () {
      final lessonId = calculator.findContinueWatchingLessonId(
        lessonIdsByCourseId: const {
          'course-a': ['a1', 'a2'],
        },
        progressByLessonId: {
          'a1': progress(lessonId: 'a1', isCompleted: true, updatedAt: 1000),
        },
      );
      expect(lessonId, isNull);
    });

    test('ignores lessons that are locked despite having stray progress', () {
      final lessonId = calculator.findContinueWatchingLessonId(
        lessonIdsByCourseId: const {
          'course-a': ['a1', 'a2'],
        },
        progressByLessonId: {
          // a1 not started/completed => a2 is locked, even though it has
          // a stray progress record.
          'a2': progress(lessonId: 'a2', positionMs: 100, updatedAt: 9999),
        },
      );
      expect(lessonId, isNull);
    });
  });

  group('resumePositionMs', () {
    test('resumes at the saved position when far from the end', () {
      final position = calculator.resumePositionMs(
        savedPositionMs: 40000,
        durationMs: 100000,
      );
      expect(position, 40000);
    });

    test('restarts at 0 when within the last 2 seconds', () {
      final position = calculator.resumePositionMs(
        savedPositionMs: 98500,
        durationMs: 100000,
      );
      expect(position, 0);
    });

    test('restarts at 0 exactly at the 2 second boundary', () {
      final position = calculator.resumePositionMs(
        savedPositionMs: 98000,
        durationMs: 100000,
      );
      expect(position, 0);
    });
  });

  group('canGoToNextLesson', () {
    test('true when the current lesson is completed and a next one exists', () {
      final canGoNext = calculator.canGoToNextLesson(
        lessonIds: const ['l1', 'l2'],
        currentLessonId: 'l1',
        progressByLessonId: {
          'l1': progress(lessonId: 'l1', isCompleted: true),
        },
      );
      expect(canGoNext, isTrue);
    });

    test('false when the current lesson is not yet completed', () {
      final canGoNext = calculator.canGoToNextLesson(
        lessonIds: const ['l1', 'l2'],
        currentLessonId: 'l1',
        progressByLessonId: const {},
      );
      expect(canGoNext, isFalse);
    });

    test('false on the last lesson of the course', () {
      final canGoNext = calculator.canGoToNextLesson(
        lessonIds: const ['l1', 'l2'],
        currentLessonId: 'l2',
        progressByLessonId: {
          'l2': progress(lessonId: 'l2', isCompleted: true),
        },
      );
      expect(canGoNext, isFalse);
    });
  });
}
