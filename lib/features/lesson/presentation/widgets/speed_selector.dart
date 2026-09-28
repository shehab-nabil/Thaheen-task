import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../generated/l10n.dart';
import '../../../settings/presentation/cubit/settings_cubit.dart';
import '../cubit/player_cubit.dart';

/// Opens the speed picker sheet. [player] and [settings] must be read from
/// the caller's own context *before* this is called: a modal bottom sheet
/// is pushed as its own route, so its builder context sits outside any
/// BlocProvider scoped to the route that opened it.
void openSpeedPicker({
  required BuildContext context,
  required PlayerCubit player,
  required SettingsCubit settings,
  required double current,
}) {
  showModalBottomSheet<void>(
    context: context,
    builder: (sheetContext) => SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: SpeedSelector(
          selected: current,
          onChanged: (speed) {
            player.setSpeed(speed);
            settings.setPlaybackSpeed(speed);
            Navigator.of(sheetContext).pop();
          },
        ),
      ),
    ),
  );
}

class SpeedSelector extends StatelessWidget {
  const SpeedSelector({
    required this.selected,
    required this.onChanged,
    super.key,
  });

  static const List<double> speeds = [1, 1.25, 1.5, 2];

  final double selected;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final s = S.of(context);

    return Wrap(
      spacing: AppSpacing.xs,
      children: [
        for (final speed in speeds)
          ChoiceChip(
            label: Text(
              s.speedMultiplier(
                speed == speed.roundToDouble()
                    ? speed.toInt().toString()
                    : speed.toString(),
              ),
            ),
            selected: selected == speed,
            onSelected: (_) => onChanged(speed),
            selectedColor: colors.primary,
            labelStyle: TextStyle(
              color: selected == speed ? colors.onPrimary : colors.onSurface,
            ),
          ),
      ],
    );
  }
}
