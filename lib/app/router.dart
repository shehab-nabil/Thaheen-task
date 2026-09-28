import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../features/course_details/presentation/cubit/course_details_cubit.dart';
import '../features/course_details/presentation/pages/course_details_page.dart';
import '../features/courses/presentation/pages/courses_page.dart';
import '../features/fullscreen_lesson/presentation/pages/fullscreen_lesson_page.dart';
import '../features/lesson/presentation/cubit/player_cubit.dart';
import '../features/lesson/presentation/pages/lesson_player_page.dart';
import 'di.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const CoursesPage()),
    GoRoute(
      path: '/course/:courseId',
      builder: (context, state) {
        final courseId = state.pathParameters['courseId']!;
        return BlocProvider<CourseDetailsCubit>(
          create: (_) => getIt<CourseDetailsCubit>(),
          child: CourseDetailsPage(courseId: courseId),
        );
      },
    ),
    GoRoute(
      path: '/course/:courseId/lesson/:lessonId',
      builder: (context, state) {
        final courseId = state.pathParameters['courseId']!;
        final lessonId = state.pathParameters['lessonId']!;
        return BlocProvider<PlayerCubit>(
          create: (_) => getIt<PlayerCubit>(),
          child: LessonPlayerPage(courseId: courseId, lessonId: lessonId),
        );
      },
    ),
    GoRoute(
      path: '/course/:courseId/lesson/:lessonId/fullscreen',
      builder: (context, state) {
        final cubit = state.extra! as PlayerCubit;
        return FullscreenLessonPage(cubit: cubit);
      },
    ),
  ],
);
