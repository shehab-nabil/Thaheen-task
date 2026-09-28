import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:thaheen_task/core/errors/failures.dart';
import 'package:thaheen_task/features/courses/data/datasources/courses_local_data_source.dart';
import 'package:thaheen_task/features/courses/data/models/course_model.dart';
import 'package:thaheen_task/features/courses/data/repositories/courses_repository_impl.dart';
import 'package:thaheen_task/features/settings/data/models/localized_text_model.dart';
import 'package:thaheen_task/generated/l10n.dart';

class MockCoursesLocalDataSource extends Mock
    implements CoursesLocalDataSource {}

void main() {
  // Repository failure messages come from S.current, which needs a loaded
  // locale before use (widget-free cubit/repository tests never trigger
  // Flutter's normal localization bootstrap).
  setUpAll(() async {
    await S.load(const Locale('ar'));
  });

  late MockCoursesLocalDataSource dataSource;
  late CoursesRepositoryImpl repository;

  setUp(() {
    dataSource = MockCoursesLocalDataSource();
    repository = CoursesRepositoryImpl(dataSource);
  });

  test('returns Right(courses) when the data source succeeds', () async {
    final course = CourseModel(
      id: 'c1',
      title: const LocalizedTextModel(ar: 'دورة'),
      instructor: const LocalizedTextModel(ar: 'مدرب'),
      thumbnail: 'assets/images/c1.png',
      sections: const [],
    );
    when(() => dataSource.getCourses()).thenAnswer((_) async => [course]);

    final result = await repository.getCourses();

    expect(result.isRight(), isTrue);
    result.fold(
      (_) => fail('expected a Right'),
      (courses) => expect(courses, [course]),
    );
  });

  test('maps a FormatException (malformed JSON) to ParseFailure', () async {
    when(
      () => dataSource.getCourses(),
    ).thenThrow(const FormatException('bad json'));

    final result = await repository.getCourses();

    expect(result.isLeft(), isTrue);
    result.fold(
      (failure) => expect(failure, isA<ParseFailure>()),
      (_) => fail('expected a Left'),
    );
  });

  test(
    'maps any other exception (e.g. missing asset) to AssetFailure',
    () async {
      when(
        () => dataSource.getCourses(),
      ).thenThrow(Exception('asset not found'));

      final result = await repository.getCourses();

      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) => expect(failure, isA<AssetFailure>()),
        (_) => fail('expected a Left'),
      );
    },
  );
}
