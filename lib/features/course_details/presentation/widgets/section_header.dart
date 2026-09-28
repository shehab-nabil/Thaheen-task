import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../generated/l10n.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({required this.number, required this.title, super.key});

  final int number;
  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        children: [
          Text(
            S.of(context).sectionNumberLabel(number),
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(child: Text(title, style: theme.textTheme.titleMedium)),
        ],
      ),
    );
  }
}
