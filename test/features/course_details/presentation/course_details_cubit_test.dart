import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:thaheen_task/core/errors/failures.dart';
import 'package:thaheen_task/core/shared/progress/data/models/lesson_progress_model.dart';
import 'package:thaheen_task/core/shared/progress/domain/services/lesson_status.dart';
import 'package:thaheen_task/core/shared/progress/domain/services/progress_calculator.dart';
import 'package:thaheen_task/core/shared/progress/domain/usecases/get_all_progress_use_case.dart';
import 'package:thaheen_task/features/course_details/domain/usecases/get_course_by_id_use_case.dart';
import 'package:thaheen_task/features/course_details/presentation/cubit/course_details_cubit.dart';
import 'package:thaheen_task/features/course_details/presentation/cubit/course_details_state.dart';
import 'package:thaheen_task/features/courses/data/models/course_model.dart';
import 'package:thaheen_task/features/courses/data/models/lesson_model.dart';
import 'package:thaheen_task/features/courses/data/models/section_model.dart';
import 'package:thaheen_task/features/settings/data/models/localized_text_model.dart';

class MockGetCourseByIdUseCase extends Mock implements GetCourseByIdUseCase {}

class MockGetAllProgressUseCase extends Mock implements GetAllProgressUseCase {}

void main() {
  late MockGetCourseByIdUseCase getCourseByIdUseCase;
  late MockGetAllProgressUseCase getAllProgressUseCase;

  final course = CourseModel(
    id: 'anatomy-101',
    title: const LocalizedTextModel(ar: 'التشريح'),
    instructor: const LocalizedTextModel(ar: 'د. سارة'),
    thumbnail: 'assets/images/anatomy.png',
    sections: [
      SectionModel(
        id: 's1',
        title: const LocalizedTextModel(ar: 'الجهاز الهيكلي'),
        lessons: [
          LessonModel(
            id: 'l1',
            title: const LocalizedTextModel(ar: 'العظام'),
            durationSec: 100,
            video: 'assets/videos/lesson1.mp4',
          ),
          LessonModel(
            id: 'l2',
            title: const LocalizedTextModel(ar: 'الغضاريف'),
            durationSec: 100,
            video: 'assets/videos/lesson2.mp4',
          ),
        ],
      ),
      SectionModel(
        id: 's2',
        title: const LocalizedTextModel(ar: 'الجهاز العضلي'),
        lessons: [
          LessonModel(
            id: 'l3',
            title: const LocalizedTextModel(ar: 'أنواع العضلات'),
            durationSec: 100,
            video: 'assets/videos/lesson1.mp4',
          ),
        ],
      ),
    ],
  );

  setUp(() {
    getCourseByIdUseCase = MockGetCourseByIdUseCase();
    getAllProgressUseCase = MockGetAllProgressUseCase();
  });

  CourseDetailsCubit buildCubit() {
    return CourseDetailsCubit(
      getCourseByIdUseCase,
      getAllProgressUseCase,
      const ProgressCalculator(),
    );
  }

  group('loadCourse', () {
    blocTest<CourseDetailsCubit, CourseDetailsState>(
      'emits [loading, success] with per-lesson statuses and progress',
      setUp: () {
        when(
          () => getCourseByIdUseCase('anatomy-101'),
        ).thenAnswer((_) async => Right(course));
        when(() => getAllProgressUseCase()).thenAnswer(
          (_) async => const Right({
            'l1': LessonProgressModel(
              lessonId: 'l1',
              positionMs: 100000,
              durationMs: 100000,
              isCompleted: true,
              updatedAt: 1,
            ),
          }),
        );
      },
      build: buildCubit,
      act: (cubit) => cubit.loadCourse('anatomy-101'),
      expect: () => [
        const CourseDetailsState.loading(),
        isA<CourseDetailsSuccess>()
            .having((s) => s.lessonStatuses, 'lessonStatuses', [
              LessonStatus.completed,
              LessonStatus.notStarted,
              LessonStatus.locked,
            ])
            .having((s) => s.progressPercent, 'progressPercent', 33)
            .having((s) => s.completedLessons, 'completedLessons', 1)
            .having(
              (s) => s.nextUnfinishedLesson?.id,
              'nextUnfinishedLesson',
              'l2',
            ),
      ],
    );

    blocTest<CourseDetailsCubit, CourseDetailsState>(
      'emits [loading, failure] when the course lookup fails',
      setUp: () {
        when(
          () => getCourseByIdUseCase('missing'),
        ).thenAnswer((_) async => const Left(ParseFailure('not found')));
      },
      build: buildCubit,
      act: (cubit) => cubit.loadCourse('missing'),
      expect: () => [
        const CourseDetailsState.loading(),
        const CourseDetailsState.failure('not found'),
      ],
    );
  });

  group('onLessonTapped', () {
    blocTest<CourseDetailsCubit, CourseDetailsState>(
      'tapping a locked lesson surfaces the locked-tap effect',
      setUp: () {
        when(
          () => getCourseByIdUseCase('anatomy-101'),
        ).thenAnswer((_) async => Right(course));
        when(() => getAllProgressUseCase()).thenAnswer(
          (_) async => const Right({
            'l1': LessonProgressModel(
              lessonId: 'l1',
              positionMs: 100000,
              durationMs: 100000,
              isCompleted: true,
              updatedAt: 1,
            ),
          }),
        );
      },
      build: buildCubit,
      act: (cubit) async {
        await cubit.loadCourse('anatomy-101');
        cubit.onLessonTapped(course.allLessons[2]); // l3, locked
      },
      skip: 2,
      expect: () => [
        isA<CourseDetailsSuccess>()
            .having((s) => s.lockedTap?.lesson.id, 'lockedTap.lesson', 'l3')
            .having(
              (s) => s.lockedTap?.requiredLesson.id,
              'lockedTap.requiredLesson',
              'l2',
            ),
      ],
    );

    blocTest<CourseDetailsCubit, CourseDetailsState>(
      'points to the first unfinished lesson, not just index - 1, when '
      'several lessons in a row are locked',
      setUp: () {
        when(
          () => getCourseByIdUseCase('anatomy-101'),
        ).thenAnswer((_) async => Right(course));
        // No progress at all: l1 is unlocked/not-started, l2 and l3 are
        // both locked (l3 locked via l2, which is itself locked via l1).
        when(
          () => getAllProgressUseCase(),
        ).thenAnswer((_) async => const Right({}));
      },
      build: buildCubit,
      act: (cubit) async {
        await cubit.loadCourse('anatomy-101');
        cubit.onLessonTapped(course.allLessons[2]); // l3, locked
      },
      skip: 2,
      expect: () => [
        isA<CourseDetailsSuccess>()
            .having((s) => s.lockedTap?.lesson.id, 'lockedTap.lesson', 'l3')
            .having(
              (s) => s.lockedTap?.requiredLesson.id,
              'lockedTap.requiredLesson',
              'l1',
            ),
      ],
    );

    blocTest<CourseDetailsCubit, CourseDetailsState>(
      'tapping an unlocked lesson does nothing',
      setUp: () {
        when(
          () => getCourseByIdUseCase('anatomy-101'),
        ).thenAnswer((_) async => Right(course));
        when(() => getAllProgressUseCase()).thenAnswer(
          (_) async => const Right({
            'l1': LessonProgressModel(
              lessonId: 'l1',
              positionMs: 100000,
              durationMs: 100000,
              isCompleted: true,
              updatedAt: 1,
            ),
          }),
        );
      },
      build: buildCubit,
      act: (cubit) async {
        await cubit.loadCourse('anatomy-101');
        cubit.onLessonTapped(course.allLessons[1]); // l2, unlocked
      },
      skip: 2,
      expect: () => <CourseDetailsState>[],
    );

    blocTest<CourseDetailsCubit, CourseDetailsState>(
      'clearLockedTap resets the effect back to null',
      setUp: () {
        when(
          () => getCourseByIdUseCase('anatomy-101'),
        ).thenAnswer((_) async => Right(course));
        when(() => getAllProgressUseCase()).thenAnswer(
          (_) async => const Right({
            'l1': LessonProgressModel(
              lessonId: 'l1',
              positionMs: 100000,
              durationMs: 100000,
              isCompleted: true,
              updatedAt: 1,
            ),
          }),
        );
      },
      build: buildCubit,
      act: (cubit) async {
        await cubit.loadCourse('anatomy-101');
        cubit.onLessonTapped(course.allLessons[2]);
        cubit.clearLockedTap();
      },
      skip: 3,
      expect: () => [
        isA<CourseDetailsSuccess>().having(
          (s) => s.lockedTap,
          'lockedTap',
          isNull,
        ),
      ],
    );
  });

  group('empty course', () {
    blocTest<CourseDetailsCubit, CourseDetailsState>(
      'emits empty when the course has no lessons',
      setUp: () {
        final emptyCourse = course.copyWith(sections: const []);
        when(
          () => getCourseByIdUseCase('anatomy-101'),
        ).thenAnswer((_) async => Right(emptyCourse));
        when(
          () => getAllProgressUseCase(),
        ).thenAnswer((_) async => const Right({}));
      },
      build: buildCubit,
      act: (cubit) => cubit.loadCourse('anatomy-101'),
      expect: () => [
        const CourseDetailsState.loading(),
        const CourseDetailsState.empty(),
      ],
    );
  });
}
