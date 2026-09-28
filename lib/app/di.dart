import 'package:get_it/get_it.dart';
import 'package:hive_ce/hive_ce.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/shared/progress/data/datasources/progress_local_data_source.dart';
import '../core/shared/progress/data/repositories/progress_repository_impl.dart';
import '../core/shared/progress/domain/repositories/progress_repository.dart';
import '../core/shared/progress/domain/services/progress_calculator.dart';
import '../core/shared/progress/domain/usecases/get_all_progress_use_case.dart';
import '../core/shared/progress/domain/usecases/mark_completed_use_case.dart';
import '../core/shared/progress/domain/usecases/save_position_use_case.dart';
import '../features/course_details/domain/usecases/get_course_by_id_use_case.dart';
import '../features/course_details/presentation/cubit/course_details_cubit.dart';
import '../features/courses/data/datasources/courses_local_data_source.dart';
import '../features/courses/data/repositories/courses_repository_impl.dart';
import '../features/courses/domain/repositories/courses_repository.dart';
import '../features/courses/domain/usecases/get_courses_use_case.dart';
import '../features/courses/presentation/cubit/courses_cubit.dart';
import '../features/lesson/domain/usecases/get_lesson_playback_data_use_case.dart';
import '../features/lesson/presentation/cubit/player_cubit.dart';
import '../features/settings/data/datasources/settings_cache_data_source.dart';
import '../features/settings/presentation/cubit/settings_cubit.dart';

final GetIt getIt = GetIt.instance;

/// Registers every dependency. Must be called once, after the Hive box and
/// SharedPreferences instance it's given have finished opening.
Future<void> setupDependencyInjection({
  required Box<Map<dynamic, dynamic>> progressBox,
  required SharedPreferences sharedPreferences,
}) async {
  // --- External instances, opened in main() before this runs ---
  getIt
    ..registerSingleton<Box<Map<dynamic, dynamic>>>(progressBox)
    ..registerSingleton<SharedPreferences>(sharedPreferences)
    ..registerLazySingleton<ProgressCalculator>(ProgressCalculator.new)
    // --- Data sources ---
    ..registerLazySingleton<CoursesLocalDataSource>(
      CoursesLocalDataSourceImpl.new,
    )
    ..registerLazySingleton<ProgressLocalDataSource>(
      () => ProgressLocalDataSourceImpl(getIt<Box<Map<dynamic, dynamic>>>()),
    )
    ..registerLazySingleton<SettingsCacheDataSource>(
      () => SettingsCacheDataSourceImpl(getIt<SharedPreferences>()),
    )
    // --- Repositories ---
    ..registerLazySingleton<CoursesRepository>(
      () => CoursesRepositoryImpl(getIt<CoursesLocalDataSource>()),
    )
    ..registerLazySingleton<ProgressRepository>(
      () => ProgressRepositoryImpl(getIt<ProgressLocalDataSource>()),
    )
    // --- Use cases ---
    ..registerLazySingleton<GetCoursesUseCase>(
      () => GetCoursesUseCase(getIt<CoursesRepository>()),
    )
    ..registerLazySingleton<GetCourseByIdUseCase>(
      () => GetCourseByIdUseCase(getIt<CoursesRepository>()),
    )
    ..registerLazySingleton<GetAllProgressUseCase>(
      () => GetAllProgressUseCase(getIt<ProgressRepository>()),
    )
    ..registerLazySingleton<SavePositionUseCase>(
      () => SavePositionUseCase(getIt<ProgressRepository>()),
    )
    ..registerLazySingleton<MarkCompletedUseCase>(
      () => MarkCompletedUseCase(getIt<ProgressRepository>()),
    )
    ..registerLazySingleton<GetLessonPlaybackDataUseCase>(
      () => GetLessonPlaybackDataUseCase(
        getIt<CoursesRepository>(),
        getIt<ProgressRepository>(),
      ),
    )
    // --- App-lifetime cubits: created once, live for the whole session ---
    ..registerLazySingleton<SettingsCubit>(
      () => SettingsCubit(getIt<SettingsCacheDataSource>()),
    )
    ..registerLazySingleton<CoursesCubit>(
      () => CoursesCubit(
        getIt<GetCoursesUseCase>(),
        getIt<GetAllProgressUseCase>(),
        getIt<ProgressCalculator>(),
      ),
    )
    // --- Per-visit cubits: MUST be factories. A page closes its cubit on
    // dispose, so a singleton would hand the next visit an already-closed
    // instance and any emit() on it would throw.
    ..registerFactory<CourseDetailsCubit>(
      () => CourseDetailsCubit(
        getIt<GetCourseByIdUseCase>(),
        getIt<GetAllProgressUseCase>(),
        getIt<ProgressCalculator>(),
      ),
    )
    ..registerFactory<PlayerCubit>(
      () => PlayerCubit(
        getIt<GetLessonPlaybackDataUseCase>(),
        getIt<SavePositionUseCase>(),
        getIt<MarkCompletedUseCase>(),
        getIt<ProgressCalculator>(),
      ),
    );
}
