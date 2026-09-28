import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/duration_formatter.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/continue_watching_model.dart';

class ContinueWatchingCard extends StatelessWidget {
  const ContinueWatchingCard({
    required this.model,
    required this.languageCode,
    required this.onTap,
    super.key,
  });

  final ContinueWatchingModel model;
  final String languageCode;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final s = S.of(context);

    final position = Duration(milliseconds: model.positionMs);
    final remaining = Duration(
      milliseconds: (model.durationMs - model.positionMs).clamp(
        0,
        model.durationMs,
      ),
    );
    final progress = model.durationMs == 0
        ? 0.0
        : model.positionMs / model.durationMs;

    return Material(
      color: colors.primary,
      borderRadius: BorderRadius.circular(AppSpacing.radiusCardLarge),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      s.continueWatchingTitle,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: colors.onPrimary.withValues(alpha: 0.8),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      model.lessonTitle.resolve(languageCode),
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: colors.onPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '${model.courseTitle.resolve(languageCode)} · '
                      '${model.sectionTitle.resolve(languageCode)}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colors.onPrimary.withValues(alpha: 0.8),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      s.lessonOfTotal(
                        model.lessonIndex + 1,
                        model.totalLessons,
                      ),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colors.onPrimary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(
                        AppSpacing.radiusChip,
                      ),
                      child: LinearProgressIndicator(
                        value: progress.clamp(0.0, 1.0),
                        minHeight: 4,
                        backgroundColor: colors.onPrimary.withValues(
                          alpha: 0.25,
                        ),
                        valueColor: AlwaysStoppedAnimation(colors.onPrimary),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Text(
                        s.stoppedAtRemaining(
                          DurationFormatter.format(position),
                          DurationFormatter.format(remaining),
                        ),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colors.onPrimary.withValues(alpha: 0.8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Container(
                width: AppSpacing.minTouchTarget,
                height: AppSpacing.minTouchTarget,
                decoration: BoxDecoration(
                  color: colors.onPrimary,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.play_arrow_rounded, color: colors.primary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
