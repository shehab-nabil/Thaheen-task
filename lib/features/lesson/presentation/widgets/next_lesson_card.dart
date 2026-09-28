import 'package:flutter/material.dart';

import '../../../../core/shared/progress/domain/services/progress_calculator.dart';
import '../../../../core/theme/app_semantic_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../generated/l10n.dart';

class NextLessonCard extends StatelessWidget {
  const NextLessonCard({
    required this.canGoNext,
    required this.onTap,
    super.key,
  });

  final bool canGoNext;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final semantic = context.semanticColors;
    final s = S.of(context);
    final percent = (ProgressCalculator.completionThreshold * 100).round();

    return Material(
      color: canGoNext ? semantic.primarySoft : semantic.lockedBackground,
      borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: canGoNext ? onTap : null,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              Icon(
                canGoNext
                    ? Icons.arrow_forward_rounded
                    : Icons.lock_outline_rounded,
                color: canGoNext ? colors.primary : semantic.lockedIcon,
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      s.nextLessonLabel,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: canGoNext ? colors.primary : semantic.lockedIcon,
                      ),
                    ),
                    if (!canGoNext)
                      Text(
                        s.nextLessonLocked(percent),
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
