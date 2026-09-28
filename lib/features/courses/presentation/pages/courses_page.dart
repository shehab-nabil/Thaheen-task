import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_empty_view.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../../../../generated/l10n.dart';
import '../../../settings/data/models/localized_text_model.dart';
import '../../../settings/data/models/theme_mode_pref.dart';
import '../../../settings/presentation/cubit/settings_cubit.dart';
import '../../../settings/presentation/cubit/settings_state.dart';
import '../../data/models/course_model.dart';
import '../cubit/courses_cubit.dart';
import '../cubit/courses_state.dart';
import '../widgets/continue_watching_card.dart';
import '../widgets/course_card.dart';
import '../widgets/course_search_field.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({super.key});

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  @override
  void initState() {
    super.initState();
    context.read<CoursesCubit>().loadCourses();
  }

  void _openCourse(String courseId) {
    context.push('/course/$courseId').then((_) {
      if (!mounted) return;
      context.read<CoursesCubit>().refresh();
    });
  }

  void _openLesson(String courseId, String lessonId) {
    context.push('/course/$courseId/lesson/$lessonId').then((_) {
      if (!mounted) return;
      context.read<CoursesCubit>().refresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.screenPadding),
          child: BlocBuilder<SettingsCubit, SettingsState>(
            buildWhen: (previous, current) =>
                previous.locale != current.locale ||
                previous.themeMode != current.themeMode,
            builder: (context, settings) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Header(settings: settings),
                  const SizedBox(height: AppSpacing.lg),
                  CourseSearchField(
                    onChanged: (query) => context.read<CoursesCubit>().search(
                      query,
                      settings.locale,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Expanded(
                    child: BlocBuilder<CoursesCubit, CoursesState>(
                      buildWhen: (previous, current) =>
                          current is CoursesInitial ||
                          current is CoursesLoading ||
                          current is CoursesFailure ||
                          current is CoursesEmpty ||
                          current is CoursesSuccess,
                      builder: (context, state) {
                        return switch (state) {
                          CoursesInitial() ||
                          CoursesLoading() => const _CoursesSkeleton(),
                          CoursesFailure(:final message) => AppErrorView(
                            message: message,
                            onRetry: () =>
                                context.read<CoursesCubit>().loadCourses(),
                          ),
                          CoursesEmpty() => AppEmptyView(
                            title: S.of(context).noCoursesYet,
                            icon: Icons.menu_book_outlined,
                          ),
                          CoursesSuccess() => _CoursesContent(
                            state: state,
                            languageCode: settings.locale,
                            onOpenCourse: _openCourse,
                            onOpenLesson: _openLesson,
                          ),
                        };
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.settings});

  final SettingsState settings;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = S.of(context);

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(s.coursesGreeting, style: theme.textTheme.bodyMedium),
              Text(s.coursesTitle, style: theme.textTheme.headlineMedium),
            ],
          ),
        ),
        IconButton(
          tooltip: s.languageToggleTooltip,
          onPressed: () => context.read<SettingsCubit>().toggleLocale(),
          icon: Text(
            settings.locale == 'ar' ? 'EN' : 'ع',
            style: theme.textTheme.labelLarge,
          ),
        ),
        IconButton(
          tooltip: s.themeToggleTooltip,
          onPressed: () => context.read<SettingsCubit>().toggleThemeMode(),
          icon: Icon(
            settings.themeMode == ThemeModePref.dark
                ? Icons.light_mode_outlined
                : Icons.dark_mode_outlined,
          ),
        ),
      ],
    );
  }
}

class _CoursesContent extends StatelessWidget {
  const _CoursesContent({
    required this.state,
    required this.languageCode,
    required this.onOpenCourse,
    required this.onOpenLesson,
  });

  final CoursesSuccess state;
  final String languageCode;
  final ValueChanged<String> onOpenCourse;
  final void Function(String courseId, String lessonId) onOpenLesson;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    if (state.filteredCourses.isEmpty) {
      return AppEmptyView(
        title: s.noSearchResults,
        icon: Icons.search_off_rounded,
      );
    }

    return ListView(
      children: [
        if (state.continueWatching != null) ...[
          ContinueWatchingCard(
            model: state.continueWatching!,
            languageCode: languageCode,
            onTap: () => onOpenLesson(
              state.continueWatching!.courseId,
              state.continueWatching!.lessonId,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
        ],
        Text(s.allCoursesTitle, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: AppSpacing.sm),
        for (final course in state.filteredCourses) ...[
          CourseCard(
            course: course,
            languageCode: languageCode,
            progressPercent: state.progressPercentByCourseId[course.id] ?? 0,
            onTap: () => onOpenCourse(course.id),
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
      ],
    );
  }
}

class _CoursesSkeleton extends StatelessWidget {
  const _CoursesSkeleton();

  @override
  Widget build(BuildContext context) {
    final fakeCourse = CourseModel(
      id: 'x',
      title: const LocalizedTextModel(ar: 'عنوان الدورة التجريبية'),
      instructor: const LocalizedTextModel(ar: 'اسم المدرب'),
      thumbnail: '',
      sections: const [],
    );

    return Skeletonizer(
      child: ListView(
        children: [
          for (var i = 0; i < 3; i++) ...[
            CourseCard(
              course: fakeCourse,
              languageCode: 'ar',
              progressPercent: 40,
              onTap: () {},
            ),
            const SizedBox(height: AppSpacing.sm),
          ],
        ],
      ),
    );
  }
}
