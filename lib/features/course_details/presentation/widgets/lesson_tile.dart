import 'package:flutter/material.dart';

import '../../../../core/shared/progress/domain/services/lesson_status.dart';
import '../../../../core/theme/app_semantic_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/duration_formatter.dart';
import '../../../../core/widgets/status_chip.dart';
import '../../../courses/data/models/lesson_model.dart';

class LessonTile extends StatelessWidget {
  const LessonTile({
    required this.lesson,
    required this.index,
    required this.status,
    required this.progressPercent,
    required this.languageCode,
    required this.onTap,
    super.key,
  });

  final LessonModel lesson;
  final int index;
  final LessonStatus status;
  final int progressPercent;
  final String languageCode;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSpacing.radiusButton),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        child: Row(
          children: [
            _StatusCircle(
              status: status,
              index: index,
              progressPercent: progressPercent,
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lesson.title.resolve(languageCode),
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: status == LessonStatus.locked
                          ? colors.onSurfaceVariant
                          : null,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Text(
                      DurationFormatter.format(
                        Duration(seconds: lesson.durationSec),
                      ),
                      style: theme.textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            StatusChip(status: status),
          ],
        ),
      ),
    );
  }
}

class _StatusCircle extends StatelessWidget {
  const _StatusCircle({
    required this.status,
    required this.index,
    required this.progressPercent,
  });

  final LessonStatus status;
  final int index;
  final int progressPercent;

  static const double _size = 36;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final semantic = context.semanticColors;

    return switch (status) {
      LessonStatus.completed => Container(
        width: _size,
        height: _size,
        decoration: BoxDecoration(
          color: colors.primary,
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.check_rounded, color: colors.onPrimary, size: 20),
      ),
      LessonStatus.inProgress => SizedBox(
        width: _size,
        height: _size,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CircularProgressIndicator(
              value: progressPercent / 100,
              strokeWidth: 2.5,
              backgroundColor: semantic.track,
              valueColor: AlwaysStoppedAnimation(semantic.inProgressText),
            ),
            Icon(
              Icons.play_arrow_rounded,
              size: 16,
              color: semantic.inProgressText,
            ),
          ],
        ),
      ),
      LessonStatus.notStarted => Container(
        width: _size,
        height: _size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: semantic.border),
        ),
        alignment: Alignment.center,
        child: Text(
          '${index + 1}',
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ),
      LessonStatus.locked => Container(
        width: _size,
        height: _size,
        decoration: BoxDecoration(
          color: semantic.lockedBackground,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Icon(
          Icons.lock_outline_rounded,
          size: 16,
          color: semantic.lockedIcon,
        ),
      ),
    };
  }
}
