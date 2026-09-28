import 'package:flutter/material.dart';

import '../../../../core/theme/app_semantic_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/course_model.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({
    required this.course,
    required this.languageCode,
    required this.progressPercent,
    required this.onTap,
    super.key,
  });

  final CourseModel course;
  final String languageCode;
  final int progressPercent;
  final VoidCallback onTap;

  static const double _thumbnailSize = 72;
  static const double _progressBarHeight = 6;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final s = S.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppSpacing.radiusButton),
                child: SizedBox(
                  width: _thumbnailSize,
                  height: _thumbnailSize,
                  child: Image.asset(
                    course.thumbnail,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: context.semanticColors.lockedBackground,
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.menu_book_rounded,
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course.title.resolve(languageCode),
                      style: theme.textTheme.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      '${course.instructor.resolve(languageCode)} · '
                      '${s.lessonsCount(course.totalLessons)}',
                      style: theme.textTheme.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(
                        AppSpacing.radiusChip,
                      ),
                      child: LinearProgressIndicator(
                        value: progressPercent / 100,
                        minHeight: _progressBarHeight,
                        backgroundColor: context.semanticColors.track,
                        valueColor: AlwaysStoppedAnimation(colors.primary),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      s.percentLabel(progressPercent),
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
