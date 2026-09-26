import '../../data/models/lesson_progress_model.dart';
import 'lesson_status.dart';

/// Pure, framework-free implementation of every progress/unlock rule in the
/// app. Operates only on lesson ids and progress records so it never
/// depends on the course data models of any particular feature.
class ProgressCalculator {
  const ProgressCalculator();

  static const double completionThreshold = 0.9;
  static const int resumeNearEndThresholdSeconds = 2;

  /// A lesson auto-completes once watched position reaches 90% of duration.
  bool isCompleted({required int positionMs, required int durationMs}) {
    if (durationMs <= 0) return false;
    return positionMs >= durationMs * completionThreshold;
  }

  /// Status of every lesson in [lessonIds] (flattened, course-ordered).
  /// Lesson 0 is always unlocked; lesson n is unlocked only if lesson n-1
  /// is completed.
  List<LessonStatus> statusesFor({
    required List<String> lessonIds,
    required Map<String, LessonProgressModel> progressByLessonId,
  }) {
    final statuses = <LessonStatus>[];
    var previousCompleted = true;
    for (final id in lessonIds) {
      final progress = progressByLessonId[id];
      final completed = progress?.isCompleted ?? false;
      if (!previousCompleted) {
        statuses.add(LessonStatus.locked);
      } else if (completed) {
        statuses.add(LessonStatus.completed);
      } else if (progress != null && progress.positionMs > 0) {
        statuses.add(LessonStatus.inProgress);
      } else {
        statuses.add(LessonStatus.notStarted);
      }
      previousCompleted = completed;
    }
    return statuses;
  }

  /// Percentage of [lessonIds] that are completed, rounded to an int.
  /// Zero for a course with no lessons.
  int courseProgressPercent({
    required List<String> lessonIds,
    required Map<String, LessonProgressModel> progressByLessonId,
  }) {
    if (lessonIds.isEmpty) return 0;
    final completed = lessonIds
        .where((id) => progressByLessonId[id]?.isCompleted ?? false)
        .length;
    return ((completed / lessonIds.length) * 100).round();
  }

  /// The lesson id of the most-recently-updated in-progress lesson across
  /// all courses, or null when there is none.
  String? findContinueWatchingLessonId({
    required Map<String, List<String>> lessonIdsByCourseId,
    required Map<String, LessonProgressModel> progressByLessonId,
  }) {
    String? latestId;
    LessonProgressModel? latest;
    for (final lessonIds in lessonIdsByCourseId.values) {
      final statuses = statusesFor(
        lessonIds: lessonIds,
        progressByLessonId: progressByLessonId,
      );
      for (var i = 0; i < lessonIds.length; i++) {
        if (statuses[i] != LessonStatus.inProgress) continue;
        final progress = progressByLessonId[lessonIds[i]];
        if (progress == null) continue;
        if (latest == null || progress.updatedAt > latest.updatedAt) {
          latest = progress;
          latestId = lessonIds[i];
        }
      }
    }
    return latestId;
  }

  /// Where to resume playback: the saved position, unless it falls within
  /// the last [resumeNearEndThresholdSeconds] of the video, in which case
  /// playback restarts from 0.
  int resumePositionMs({required int savedPositionMs, required int durationMs}) {
    if (durationMs <= 0) return savedPositionMs;
    final remainingMs = durationMs - savedPositionMs;
    if (remainingMs <= resumeNearEndThresholdSeconds * 1000) return 0;
    return savedPositionMs;
  }

  /// Whether the lesson after [currentLessonId] in [lessonIds] can be
  /// navigated to: there must be a next lesson, and rule 2 requires the
  /// current lesson to be completed to unlock it.
  bool canGoToNextLesson({
    required List<String> lessonIds,
    required String currentLessonId,
    required Map<String, LessonProgressModel> progressByLessonId,
  }) {
    final index = lessonIds.indexOf(currentLessonId);
    if (index == -1 || index >= lessonIds.length - 1) return false;
    return progressByLessonId[currentLessonId]?.isCompleted ?? false;
  }
}
