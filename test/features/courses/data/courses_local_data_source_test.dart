import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:thaheen_task/features/courses/data/datasources/courses_local_data_source.dart';

class FakeAssetBundle extends AssetBundle {
  FakeAssetBundle(this._files);

  final Map<String, String> _files;

  @override
  Future<ByteData> load(String key) => throw UnimplementedError();

  @override
  Future<String> loadString(String key, {bool cache = true}) async {
    final content = _files[key];
    if (content == null) {
      throw Exception('Unable to load asset: $key');
    }
    return content;
  }
}

void main() {
  const assetPath = 'assets/data/courses.json';

  const validJson = '''
{
  "courses": [
    {
      "id": "c1",
      "title": { "ar": "دورة تجريبية" },
      "instructor": { "ar": "مدرب" },
      "thumbnail": "assets/images/c1.png",
      "sections": [
        {
          "id": "c1-s1",
          "title": { "ar": "قسم" },
          "lessons": [
            {
              "id": "c1-l1",
              "title": { "ar": "درس" },
              "durationSec": 60,
              "video": "assets/videos/l1.mp4"
            }
          ]
        }
      ]
    }
  ]
}
''';

  test(
    'parses valid JSON into courses, including missing optional fields',
    () async {
      final dataSource = CoursesLocalDataSourceImpl(
        bundle: FakeAssetBundle({assetPath: validJson}),
      );

      final courses = await dataSource.getCourses();

      expect(courses, hasLength(1));
      expect(courses.single.id, 'c1');
      expect(courses.single.title.ar, 'دورة تجريبية');
      expect(
        courses.single.title.en,
        '',
      ); // omitted in JSON, falls back to default
      expect(courses.single.allLessons, hasLength(1));
    },
  );

  test('throws on malformed (syntactically invalid) JSON', () async {
    final dataSource = CoursesLocalDataSourceImpl(
      bundle: FakeAssetBundle({assetPath: '{ not valid json'}),
    );

    expect(dataSource.getCourses(), throwsFormatException);
  });

  test('an empty courses array yields an empty list', () async {
    final dataSource = CoursesLocalDataSourceImpl(
      bundle: FakeAssetBundle({assetPath: '{"courses": []}'}),
    );

    final courses = await dataSource.getCourses();

    expect(courses, isEmpty);
  });

  test(
    'skips a single malformed course entry rather than failing the list',
    () async {
      const jsonWithOneBadCourse = '''
{
  "courses": [
    { "title": { "ar": "بلا معرف" } },
    {
      "id": "c2",
      "title": { "ar": "دورة صالحة" },
      "instructor": { "ar": "مدرب" },
      "thumbnail": "assets/images/c2.png",
      "sections": []
    }
  ]
}
''';
      final dataSource = CoursesLocalDataSourceImpl(
        bundle: FakeAssetBundle({assetPath: jsonWithOneBadCourse}),
      );

      final courses = await dataSource.getCourses();

      expect(courses, hasLength(1));
      expect(courses.single.id, 'c2');
    },
  );
}
