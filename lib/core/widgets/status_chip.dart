import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../shared/progress/domain/services/lesson_status.dart';
import '../theme/app_semantic_colors.dart';
import '../theme/app_spacing.dart';

/// The مكتمل / قيد المشاهدة / لم يبدأ / مقفل chip, shared by the course
/// details lesson list and the lesson player page so the status → label →
/// color mapping exists in exactly one place.
class StatusChip extends StatelessWidget {
  const StatusChip({required this.status, super.key});

  final LessonStatus status;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final semantic = context.semanticColors;
    final s = S.of(context);

    final label = switch (status) {
      LessonStatus.completed => s.statusCompleted,
      LessonStatus.inProgress => s.statusInProgress,
      LessonStatus.notStarted => s.statusNotStarted,
      LessonStatus.locked => s.statusLocked,
    };
    final (background, foreground) = switch (status) {
      LessonStatus.completed => (semantic.primarySoft, colors.primary),
      LessonStatus.inProgress => (
        semantic.inProgressBackground,
        semantic.inProgressText,
      ),
      LessonStatus.notStarted => (semantic.track, colors.onSurfaceVariant),
      LessonStatus.locked => (semantic.lockedBackground, semantic.lockedIcon),
    };

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppSpacing.radiusChip),
      ),
      child: Text(
        label,
        style: Theme.of(
          context,
        ).textTheme.labelMedium?.copyWith(color: foreground),
      ),
    );
  }
}
