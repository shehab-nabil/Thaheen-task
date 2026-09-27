import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/course_model.dart';

abstract class CoursesLocalDataSource {
  Future<List<CourseModel>> getCourses();
}

class CoursesLocalDataSourceImpl implements CoursesLocalDataSource {
  CoursesLocalDataSourceImpl({AssetBundle? bundle})
      : _bundle = bundle ?? rootBundle;

  static const String _assetPath = 'assets/data/courses.json';

  final AssetBundle _bundle;

  @override
  Future<List<CourseModel>> getCourses() async {
    final raw = await _bundle.loadString(_assetPath);
    final decoded = jsonDecode(raw);
    if (decoded is! Map<String, dynamic>) {
      throw const FormatException('courses.json root must be an object');
    }

    final coursesJson = decoded['courses'];
    if (coursesJson is! List) return [];

    final courses = <CourseModel>[];
    for (final item in coursesJson) {
      if (item is! Map<String, dynamic>) continue;
      try {
        courses.add(CourseModel.fromJson(item));
      } catch (_) {
        // Skip a single malformed course rather than failing the whole list.
        continue;
      }
    }
    return courses;
  }
}
