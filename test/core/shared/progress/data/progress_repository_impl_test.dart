import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:thaheen_task/core/errors/failures.dart';
import 'package:thaheen_task/core/shared/progress/data/datasources/progress_local_data_source.dart';
import 'package:thaheen_task/core/shared/progress/data/models/lesson_progress_model.dart';
import 'package:thaheen_task/core/shared/progress/data/repositories/progress_repository_impl.dart';
import 'package:thaheen_task/generated/l10n.dart';

class MockProgressLocalDataSource extends Mock
    implements ProgressLocalDataSource {}

void main() {
  setUpAll(() async {
    await S.load(const Locale('ar'));
  });

  late MockProgressLocalDataSource dataSource;
  late ProgressRepositoryImpl repository;

  setUp(() {
    dataSource = MockProgressLocalDataSource();
    repository = ProgressRepositoryImpl(dataSource);
  });

  const progress = LessonProgressModel(
    lessonId: 'l1',
    positionMs: 1000,
    durationMs: 5000,
    isCompleted: false,
    updatedAt: 1,
  );

  test('getAllProgress returns Right with the data source map', () async {
    when(() => dataSource.getAll()).thenReturn({'l1': progress});

    final result = await repository.getAllProgress();

    expect(result.isRight(), isTrue);
    result.fold(
      (_) => fail('expected a Right'),
      (map) => expect(map['l1'], progress),
    );
  });

  test('getAllProgress maps a data source exception to CacheFailure', () async {
    when(() => dataSource.getAll()).thenThrow(Exception('box closed'));

    final result = await repository.getAllProgress();

    expect(result.isLeft(), isTrue);
    result.fold(
      (failure) => expect(failure, isA<CacheFailure>()),
      (_) => fail('expected a Left'),
    );
  });

  test('saveProgress writes through to the data source', () async {
    when(() => dataSource.save(progress)).thenAnswer((_) async {});

    final result = await repository.saveProgress(progress);

    expect(result.isRight(), isTrue);
    verify(() => dataSource.save(progress)).called(1);
  });
}
