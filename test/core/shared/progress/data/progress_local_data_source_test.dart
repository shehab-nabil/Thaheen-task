import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive_ce.dart';
import 'package:mocktail/mocktail.dart';
import 'package:thaheen_task/core/shared/progress/data/datasources/progress_local_data_source.dart';
import 'package:thaheen_task/core/shared/progress/data/models/lesson_progress_model.dart';

class MockBox extends Mock implements Box<Map<dynamic, dynamic>> {}

void main() {
  late MockBox box;
  late ProgressLocalDataSourceImpl dataSource;

  setUp(() {
    box = MockBox();
    dataSource = ProgressLocalDataSourceImpl(box);
  });

  group('get', () {
    test('decodes a stored map back into a LessonProgressModel', () {
      when(() => box.get('l1')).thenReturn({
        'lessonId': 'l1',
        'positionMs': 1000,
        'durationMs': 5000,
        'isCompleted': false,
        'updatedAt': 123,
      });

      final progress = dataSource.get('l1');

      expect(progress, isNotNull);
      expect(progress!.lessonId, 'l1');
      expect(progress.positionMs, 1000);
    });

    test('returns null when nothing is stored for that lesson', () {
      when(() => box.get('missing')).thenReturn(null);

      expect(dataSource.get('missing'), isNull);
    });

    test(
      'returns null instead of throwing when the stored value is malformed',
      () {
        when(() => box.get('bad')).thenReturn({'unexpected': 'shape'});

        expect(dataSource.get('bad'), isNull);
      },
    );
  });

  group('getAll', () {
    test('decodes every entry, skipping malformed ones', () {
      when(() => box.keys).thenReturn(['l1', 'l2']);
      when(() => box.get('l1')).thenReturn({
        'lessonId': 'l1',
        'positionMs': 1000,
        'durationMs': 5000,
        'isCompleted': true,
        'updatedAt': 123,
      });
      when(() => box.get('l2')).thenReturn({'unexpected': 'shape'});

      final all = dataSource.getAll();

      expect(all.keys, ['l1']);
      expect(all['l1']!.isCompleted, isTrue);
    });
  });

  group('save', () {
    test('writes the progress as a JSON map keyed by lessonId', () async {
      when(
        () => box.put(any<String>(), any<Map<String, dynamic>>()),
      ).thenAnswer((_) async {});

      const progress = LessonProgressModel(
        lessonId: 'l1',
        positionMs: 2000,
        durationMs: 5000,
        isCompleted: false,
        updatedAt: 999,
      );

      await dataSource.save(progress);

      final captured =
          verify(() => box.put('l1', captureAny())).captured.single
              as Map<dynamic, dynamic>;
      expect(captured['lessonId'], 'l1');
      expect(captured['positionMs'], 2000);
    });
  });
}
