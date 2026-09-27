import 'package:hive_ce/hive_ce.dart';

import '../models/lesson_progress_model.dart';

abstract class ProgressLocalDataSource {
  Map<String, LessonProgressModel> getAll();
  LessonProgressModel? get(String lessonId);
  Future<void> save(LessonProgressModel progress);
}

class ProgressLocalDataSourceImpl implements ProgressLocalDataSource {
  const ProgressLocalDataSourceImpl(this._box);

  final Box<Map<dynamic, dynamic>> _box;

  @override
  Map<String, LessonProgressModel> getAll() {
    final result = <String, LessonProgressModel>{};
    for (final key in _box.keys) {
      final progress = _decode(key);
      if (progress != null) result[progress.lessonId] = progress;
    }
    return result;
  }

  @override
  LessonProgressModel? get(String lessonId) => _decode(lessonId);

  @override
  Future<void> save(LessonProgressModel progress) {
    return _box.put(progress.lessonId, progress.toJson());
  }

  LessonProgressModel? _decode(dynamic key) {
    final raw = _box.get(key);
    if (raw == null) return null;
    try {
      return LessonProgressModel.fromJson(Map<String, dynamic>.from(raw));
    } catch (_) {
      return null;
    }
  }
}
