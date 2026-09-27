import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:thaheen_task/core/errors/failures.dart';
import 'package:thaheen_task/core/shared/progress/data/models/lesson_progress_model.dart';
import 'package:thaheen_task/core/shared/progress/domain/services/progress_calculator.dart';
import 'package:thaheen_task/core/shared/progress/domain/usecases/get_all_progress_use_case.dart';
import 'package:thaheen_task/features/courses/data/models/course_model.dart';
import 'package:thaheen_task/features/courses/data/models/lesson_model.dart';
import 'package:thaheen_task/features/courses/data/models/section_model.dart';
import 'package:thaheen_task/features/settings/data/models/localized_text_model.dart';
import 'package:thaheen_task/features/courses/domain/usecases/get_courses_use_case.dart';
import 'package:thaheen_task/features/courses/presentation/cubit/courses_cubit.dart';
import 'package:thaheen_task/features/courses/presentation/cubit/courses_state.dart';

class MockGetCoursesUseCase extends Mock implements GetCoursesUseCase {}

class MockGetAllProgressUseCase extends Mock implements GetAllProgressUseCase {}

void main() {
  late MockGetCoursesUseCase getCoursesUseCase;
  late MockGetAllProgressUseCase getAllProgressUseCase;

  final anatomy = CourseModel(
    id: 'anatomy-101',
    title: const LocalizedTextModel(ar: 'مقدمة في التشريح', en: 'Anatomy'),
    instructor: const LocalizedTextModel(ar: 'د. سارة', en: 'Dr. Sara'),
    thumbnail: 'assets/images/anatomy.png',
    sections: [
      SectionModel(
        id: 's1',
        title: const LocalizedTextModel(ar: 'القسم الأول'),
        lessons: [
          LessonModel(
            id: 'l1',
            title: const LocalizedTextModel(ar: 'العظام'),
            durationSec: 100,
            video: 'assets/videos/lesson1.mp4',
          ),
        ],
      ),
    ],
  );

  final physiology = CourseModel(
    id: 'physiology-101',
    title: const LocalizedTextModel(ar: 'وظائف الأعضاء', en: 'Physiology'),
    instructor: const LocalizedTextModel(ar: 'د. أحمد', en: 'Dr. Ahmed'),
    thumbnail: 'assets/images/physiology.png',
    sections: [
      SectionModel(
        id: 's2',
        title: const LocalizedTextModel(ar: 'القسم الثاني'),
        lessons: [
          LessonModel(
            id: 'l2',
            title: const LocalizedTextModel(ar: 'القلب'),
            durationSec: 100,
            video: 'assets/videos/lesson2.mp4',
          ),
        ],
      ),
    ],
  );

  setUp(() {
    getCoursesUseCase = MockGetCoursesUseCase();
    getAllProgressUseCase = MockGetAllProgressUseCase();
  });

  CoursesCubit buildCubit() {
    return CoursesCubit(
      getCoursesUseCase,
      getAllProgressUseCase,
      const ProgressCalculator(),
    );
  }

  group('loadCourses', () {
    blocTest<CoursesCubit, CoursesState>(
      'emits [loading, success] with computed progress when courses load',
      setUp: () {
        when(() => getCoursesUseCase()).thenAnswer(
          (_) async => Right([anatomy, physiology]),
        );
        when(() => getAllProgressUseCase()).thenAnswer(
          (_) async => const Right({}),
        );
      },
      build: buildCubit,
      act: (cubit) => cubit.loadCourses(),
      expect: () => [
        const CoursesState.loading(),
        isA<CoursesSuccess>()
            .having((s) => s.courses.length, 'courses.length', 2)
            .having(
              (s) => s.progressPercentByCourseId,
              'progressPercentByCourseId',
              {'anatomy-101': 0, 'physiology-101': 0},
            )
            .having((s) => s.continueWatching, 'continueWatching', isNull)
            .having((s) => s.query, 'query', ''),
      ],
    );

    blocTest<CoursesCubit, CoursesState>(
      'emits [loading, failure] when the courses use case fails',
      setUp: () {
        when(() => getCoursesUseCase()).thenAnswer(
          (_) async => const Left(ParseFailure('boom')),
        );
      },
      build: buildCubit,
      act: (cubit) => cubit.loadCourses(),
      expect: () => [
        const CoursesState.loading(),
        const CoursesState.failure('boom'),
      ],
    );

    blocTest<CoursesCubit, CoursesState>(
      'emits [loading, empty] when there are no courses',
      setUp: () {
        when(() => getCoursesUseCase()).thenAnswer((_) async => const Right([]));
        when(() => getAllProgressUseCase()).thenAnswer(
          (_) async => const Right({}),
        );
      },
      build: buildCubit,
      act: (cubit) => cubit.loadCourses(),
      expect: () => [
        const CoursesState.loading(),
        const CoursesState.empty(),
      ],
    );

    blocTest<CoursesCubit, CoursesState>(
      'builds the continue-watching card from the in-progress lesson',
      setUp: () {
        when(() => getCoursesUseCase()).thenAnswer(
          (_) async => Right([anatomy, physiology]),
        );
        when(() => getAllProgressUseCase()).thenAnswer(
          (_) async => const Right({
            'l1': LessonProgressModel(
              lessonId: 'l1',
              positionMs: 30000,
              durationMs: 100000,
              isCompleted: false,
              updatedAt: 1000,
            ),
          }),
        );
      },
      build: buildCubit,
      act: (cubit) => cubit.loadCourses(),
      expect: () => [
        const CoursesState.loading(),
        isA<CoursesSuccess>().having(
          (s) => s.continueWatching?.lessonId,
          'continueWatching.lessonId',
          'l1',
        ),
      ],
    );
  });

  group('search', () {
    blocTest<CoursesCubit, CoursesState>(
      'filters courses by title/instructor in the given language',
      setUp: () {
        when(() => getCoursesUseCase()).thenAnswer(
          (_) async => Right([anatomy, physiology]),
        );
        when(() => getAllProgressUseCase()).thenAnswer(
          (_) async => const Right({}),
        );
      },
      build: buildCubit,
      act: (cubit) async {
        await cubit.loadCourses();
        cubit.search('سارة', 'ar');
      },
      skip: 1,
      expect: () => [
        isA<CoursesSuccess>() // after loadCourses success
            .having((s) => s.filteredCourses.length, 'filteredCourses', 2),
        isA<CoursesSuccess>()
            .having((s) => s.filteredCourses.length, 'filteredCourses', 1)
            .having((s) => s.filteredCourses.single.id, 'match', 'anatomy-101')
            .having((s) => s.query, 'query', 'سارة'),
      ],
    );

    blocTest<CoursesCubit, CoursesState>(
      'clearing the query restores the full course list',
      setUp: () {
        when(() => getCoursesUseCase()).thenAnswer(
          (_) async => Right([anatomy, physiology]),
        );
        when(() => getAllProgressUseCase()).thenAnswer(
          (_) async => const Right({}),
        );
      },
      build: buildCubit,
      act: (cubit) async {
        await cubit.loadCourses();
        cubit.search('سارة', 'ar');
        cubit.search('', 'ar');
      },
      skip: 3,
      expect: () => [
        isA<CoursesSuccess>()
            .having((s) => s.filteredCourses.length, 'filteredCourses', 2)
            .having((s) => s.query, 'query', ''),
      ],
    );

    blocTest<CoursesCubit, CoursesState>(
      'is a no-op before courses are loaded',
      build: buildCubit,
      act: (cubit) => cubit.search('anything', 'ar'),
      expect: () => <CoursesState>[],
    );
  });
}
