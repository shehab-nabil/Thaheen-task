import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../settings/data/models/localized_text_model.dart';

part 'continue_watching_model.freezed.dart';

/// Display data for the "Continue Watching" card: the single most-recently
/// updated in-progress lesson across all courses. Computed by CoursesCubit,
/// never persisted, so this holds no fromJson/toJson.
@freezed
abstract class ContinueWatchingModel with _$ContinueWatchingModel {
  const factory ContinueWatchingModel({
    required String courseId,
    required String lessonId,
    required LocalizedTextModel courseTitle,
    required LocalizedTextModel sectionTitle,
    required LocalizedTextModel lessonTitle,
    required int lessonIndex,
    required int totalLessons,
    required int positionMs,
    required int durationMs,
  }) = _ContinueWatchingModel;
}
