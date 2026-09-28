import 'package:flutter/material.dart';

import '../../../../core/theme/app_semantic_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../generated/l10n.dart';
import '../cubit/course_details_state.dart';

class LockedLessonSheet extends StatelessWidget {
  const LockedLessonSheet({
    required this.tap,
    required this.languageCode,
    required this.onOpenRequired,
    super.key,
  });

  final LockedLessonTap tap;
  final String languageCode;
  final VoidCallback onOpenRequired;

  static Future<void> show(
    BuildContext context, {
    required LockedLessonTap tap,
    required String languageCode,
    required VoidCallback onOpenRequired,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (context) => LockedLessonSheet(
        tap: tap,
        languageCode: languageCode,
        onOpenRequired: onOpenRequired,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final semantic = context.semanticColors;
    final s = S.of(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: semantic.lockedBackground,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Icon(
                Icons.lock_outline_rounded,
                color: semantic.lockedIcon,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              s.lockedSheetTitle,
              style: theme.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              s.lockedSheetBody(
                tap.requiredLesson.title.resolve(languageCode),
                tap.lesson.title.resolve(languageCode),
              ),
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xl),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                onOpenRequired();
              },
              child: Text(
                s.lockedSheetOpenRequired(
                  tap.requiredLesson.title.resolve(languageCode),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(s.lockedSheetOk),
            ),
          ],
        ),
      ),
    );
  }
}
