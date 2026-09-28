import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../core/theme/app_theme.dart';
import '../features/courses/presentation/cubit/courses_cubit.dart';
import '../features/settings/data/models/theme_mode_pref.dart';
import '../features/settings/presentation/cubit/settings_cubit.dart';
import '../features/settings/presentation/cubit/settings_state.dart';
import '../generated/l10n.dart';
import 'di.dart';
import 'router.dart';

class ThaheenApp extends StatelessWidget {
  const ThaheenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SettingsCubit>(create: (_) => getIt<SettingsCubit>()),
        BlocProvider<CoursesCubit>(create: (_) => getIt<CoursesCubit>()),
      ],
      child: BlocBuilder<SettingsCubit, SettingsState>(
        buildWhen: (previous, current) =>
            previous.locale != current.locale ||
            previous.themeMode != current.themeMode,
        builder: (context, settings) {
          return MaterialApp.router(
            // onGenerateTitle (not `title`) because it's called with a
            // BuildContext already inside the Localizations subtree;
            // S.current here would throw before the very first frame,
            // since nothing has loaded a locale yet at this point.
            onGenerateTitle: (context) => S.of(context).appTitle,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: switch (settings.themeMode) {
              ThemeModePref.light => ThemeMode.light,
              ThemeModePref.dark => ThemeMode.dark,
              ThemeModePref.system => ThemeMode.system,
            },
            locale: Locale(settings.locale),
            supportedLocales: S.delegate.supportedLocales,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            routerConfig: appRouter,
          );
        },
      ),
    );
  }
}
