import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/shared/progress/domain/services/lesson_status.dart';
import '../../../../core/theme/app_semantic_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_empty_view.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../../../../generated/l10n.dart';
import '../../../courses/data/models/course_model.dart';
import '../../../courses/data/models/lesson_model.dart';
import '../../../settings/data/models/localized_text_model.dart';
import '../../../settings/presentation/cubit/settings_cubit.dart';
import '../cubit/course_details_cubit.dart';
import '../cubit/course_details_state.dart';
import '../widgets/lesson_tile.dart';
import '../widgets/locked_lesson_sheet.dart';
import '../widgets/section_header.dart';

class CourseDetailsPage extends StatefulWidget {
  const CourseDetailsPage({required this.courseId, super.key});

  final String courseId;

  @override
  State<CourseDetailsPage> createState() => _CourseDetailsPageState();
}

class _CourseDetailsPageState extends State<CourseDetailsPage> {
  @override
  void initState() {
    super.initState();
    context.read<CourseDetailsCubit>().loadCourse(widget.courseId);
  }

  void _openLesson(String lessonId) {
    context.push('/course/${widget.courseId}/lesson/$lessonId').then((_) {
      if (!mounted) return;
      context.read<CourseDetailsCubit>().refresh();
    });
  }

  void _onLessonTap(LessonModel lesson, LessonStatus status) {
    if (status == LessonStatus.locked) {
      context.read<CourseDetailsCubit>().onLessonTapped(lesson);
    } else {
      _openLesson(lesson.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final languageCode = context.select<SettingsCubit, String>(
      (cubit) => cubit.state.locale,
    );

    return Scaffold(
      appBar: AppBar(leading: const BackButton()),
      body: BlocListener<CourseDetailsCubit, CourseDetailsState>(
        listenWhen: (previous, current) =>
            current is CourseDetailsSuccess && current.lockedTap != null,
        listener: (context, state) {
          final tap = (state as CourseDetailsSuccess).lockedTap!;
          LockedLessonSheet.show(
            context,
            tap: tap,
            languageCode: languageCode,
            onOpenRequired: () => _openLesson(tap.requiredLesson.id),
          ).then((_) {
            if (!context.mounted) return;
            context.read<CourseDetailsCubit>().clearLockedTap();
          });
        },
        child: BlocBuilder<CourseDetailsCubit, CourseDetailsState>(
          buildWhen: (previous, current) =>
              current is CourseDetailsInitial ||
              current is CourseDetailsLoading ||
              current is CourseDetailsFailure ||
              current is CourseDetailsEmpty ||
              current is CourseDetailsSuccess,
          builder: (context, state) {
            return switch (state) {
              CourseDetailsInitial() ||
              CourseDetailsLoading() => const _DetailsSkeleton(),
              CourseDetailsFailure(:final message) => AppErrorView(
                message: message,
                onRetry: () => context.read<CourseDetailsCubit>().loadCourse(
                  widget.courseId,
                ),
              ),
              CourseDetailsEmpty() => AppEmptyView(
                title: S.of(context).emptyCourseTitle,
                icon: Icons.menu_book_outlined,
                actionLabel: S.of(context).backToCourses,
                onAction: () => context.pop(),
              ),
              CourseDetailsSuccess() => _DetailsContent(
                state: state,
                languageCode: languageCode,
                onLessonTap: _onLessonTap,
                onContinue: () {
                  final next = state.nextUnfinishedLesson;
                  if (next != null) _openLesson(next.id);
                },
              ),
            };
          },
        ),
      ),
    );
  }
}

class _DetailsContent extends StatelessWidget {
  const _DetailsContent({
    required this.state,
    required this.languageCode,
    required this.onLessonTap,
    required this.onContinue,
  });

  final CourseDetailsSuccess state;
  final String languageCode;
  final void Function(LessonModel lesson, LessonStatus status) onLessonTap;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    final course = state.course;
    final s = S.of(context);

    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenPadding,
            ),
            children: [
              _HeaderCard(
                course: course,
                languageCode: languageCode,
                state: state,
              ),
              const SizedBox(height: AppSpacing.lg),
              for (final section in course.sections) ...[
                SectionHeader(
                  number: course.sections.indexOf(section) + 1,
                  title: section.title.resolve(languageCode),
                ),
                for (final lesson in section.lessons)
                  Builder(
                    builder: (context) {
                      final index = course.allLessons.indexWhere(
                        (l) => l.id == lesson.id,
                      );
                      return LessonTile(
                        lesson: lesson,
                        index: index,
                        status: state.lessonStatuses[index],
                        progressPercent: state.lessonProgressPercent[index],
                        languageCode: languageCode,
                        onTap: () =>
                            onLessonTap(lesson, state.lessonStatuses[index]),
                      );
                    },
                  ),
                const SizedBox(height: AppSpacing.sm),
              ],
              const SizedBox(height: AppSpacing.xxxl),
            ],
          ),
        ),
        if (state.nextUnfinishedLesson != null)
          SafeArea(
            minimum: const EdgeInsets.all(AppSpacing.screenPadding),
            child: ElevatedButton(
              onPressed: onContinue,
              child: Text(
                s.continueLessonButton(
                  state.nextUnfinishedLesson!.title.resolve(languageCode),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _HeaderCard extends StatelessWidget {
  const _HeaderCard({
    required this.course,
    required this.languageCode,
    required this.state,
  });

  final CourseModel course;
  final String languageCode;
  final CourseDetailsSuccess state;

  static const double _progressBarHeight = 6;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final s = S.of(context);

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSpacing.radiusButton),
              child: AspectRatio(
                aspectRatio: 16 / 9,
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
            const SizedBox(height: AppSpacing.md),
            Text(
              course.title.resolve(languageCode),
              style: theme.textTheme.headlineSmall,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              s.courseDetailsSubtitle(
                course.instructor.resolve(languageCode),
                s.sectionsCount(course.sections.length),
                s.lessonsCount(course.totalLessons),
              ),
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(height: AppSpacing.md),
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSpacing.radiusChip),
              child: LinearProgressIndicator(
                value: state.progressPercent / 100,
                minHeight: _progressBarHeight,
                backgroundColor: context.semanticColors.track,
                valueColor: AlwaysStoppedAnimation(colors.primary),
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              s.overallProgressLabel(
                state.progressPercent,
                state.completedLessons,
                course.totalLessons,
              ),
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailsSkeleton extends StatelessWidget {
  const _DetailsSkeleton();

  @override
  Widget build(BuildContext context) {
    final fakeCourse = CourseModel(
      id: 'x',
      title: const LocalizedTextModel(ar: 'عنوان الدورة'),
      instructor: const LocalizedTextModel(ar: 'اسم المدرب'),
      thumbnail: '',
      sections: const [],
    );
    final fakeState =
        CourseDetailsState.success(
              course: fakeCourse,
              lessonStatuses: const [],
              lessonProgressPercent: const [],
              progressPercent: 40,
              completedLessons: 2,
            )
            as CourseDetailsSuccess;

    return Skeletonizer(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.screenPadding),
        child: _HeaderCard(
          course: fakeCourse,
          languageCode: 'ar',
          state: fakeState,
        ),
      ),
    );
  }
}
