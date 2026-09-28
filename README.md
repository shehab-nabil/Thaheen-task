# ذهين (Thaheen)

A small offline, Arabic-first mini LMS built with Flutter. Two courses, video
lessons with sequential unlock, resume, and progress tracking — all from
bundled assets, no backend.

## 1. How to run

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
dart run intl_utils:generate
flutter run
flutter test
```

Video assets: `assets/videos/lesson1.mp4` and `assets/videos/lesson2.mp4` are
already bundled (two short CC-licensed clips, reused across all lessons — see
§9). If you ever need to replace them, keep the same filenames or update
`assets/data/courses.json`'s `video` fields.

## 2. Architecture

Clean Architecture (data → domain → presentation), **feature-first**, with one
deliberate twist from a typical "courses + player" grouping: every *screen*
is its own top-level feature, and cross-cutting logic that isn't a screen
lives under `core/shared/`.

```
lib/
  app/            MaterialApp.router, go_router config, get_it registrations
  core/
    theme/        design tokens (colors, spacing, text styles) + ThemeExtension
    errors/       Failure hierarchy
    storage/      Hive box names, SharedPreferences keys
    utils/        DurationFormatter
    widgets/      AppErrorView, AppEmptyView
    shared/
      progress/   data+domain for progress: Hive box, ProgressCalculator,
                  use cases. Shared by courses, course_details and lesson —
                  it has no screen of its own, so it doesn't live under
                  features/ (see §3).
  features/
    courses/          Courses list screen
    course_details/   Course details screen
    lesson/            Lesson player screen
    fullscreen_lesson/ Fullscreen video screen (presentation-only)
    settings/          Locale / theme / playback-speed preferences
  generated/      intl_utils output (S class) — generated, don't edit
  l10n/           intl_ar.arb (main), intl_en.arb
```

Each screen-owning feature follows `data → domain → presentation` internally
(datasources/models/repositories, then repositories'-abstractions/usecases,
then cubit/pages/widgets). `course_details` and `lesson` each have their own
`domain/usecases/` that call `CoursesRepository`/`ProgressRepository`
directly — those repositories are owned and implemented once (in `courses`
and `core/shared/progress` respectively) and reused, rather than each screen
re-implementing data access.

**Why Clean Architecture / feature-first:** keeps business rules (unlock,
completion, resume) testable in isolation from Flutter and from any one
screen, and keeps each screen's files next to each other instead of spread
across `models/`, `blocs/`, `screens/` top-level folders.

**Why go_router:** declarative routes with path parameters
(`/course/:courseId/lesson/:lessonId`) map directly onto the screen
hierarchy, and `extra` is what lets the fullscreen route receive the *same*
`PlayerCubit` instance as the lesson screen it was pushed from (§8).

**Why get_it:** a single place to see every dependency and its lifetime
(singleton vs factory — see §12), without threading constructors through
every widget by hand.

## 3. Why `progress` lives in `core/shared`, not `features/`

`progress` owns the Hive-backed storage of each lesson's watched
position/completion, and the pure business rules (§8). It isn't a screen —
`courses` reads it for progress bars and the continue-watching card,
`course_details` reads it for lock/status per lesson, and `lesson` reads and
writes it while playing. Putting it under `core/shared/` instead of
`features/` makes that "used by everyone, owned by no screen" role explicit,
and avoids duplicating the Hive access code and the unlock/completion rules
in three places.

`LocalizedTextModel` (the `{ar, en}` wrapper used by course/section/lesson
titles) similarly isn't owned by any one screen, but by explicit choice for
this task it lives in `features/settings/data/models/` rather than
`core/`, since resolving it depends on the locale that `settings` owns.

## 4. Why no entities

For an offline app with exactly one data source (`courses.json`, one Hive
box, SharedPreferences), a separate entity layer would only duplicate the
freezed models and add mapping code between "entity" and "model" that never
diverges. The freezed data-layer models (`CourseModel`, `LessonModel`,
`LessonProgressModel`, ...) are already immutable with value equality, so
they're used directly across data, domain and presentation. Trade-off: if a
real API with a different response shape were added later, entities would
earn their keep then, as a translation boundary.

## 5. Why dartz (`Either<Failure, T>`)

Every repository and use case returns `Future<Either<Failure, T>>`. Errors
become part of the function signature, so every caller must handle both
branches with `.fold`. Nothing throws past a repository — nothing needs a
red-screen crash handler for a missing asset or a Hive read failure. No
hand-written `Result` class to maintain, and the pattern is standard/legible.

## 6. Why Cubit + freezed union states

Same shape in every feature: `initial / loading / success / empty / failure`
(cubits with more shape, like `PlayerState.ready`, still follow the same
`sealed class` pattern).

- Each state is its own type, so "loading *and* error at once" can't be
  represented — the compiler enforces it, not a convention.
- A Dart 3 `switch` over the sealed class makes the UI handle every state;
  missing one is a compile error, not a runtime gap.
- Generated `==`, `hashCode`, `copyWith`, `toString` remove boilerplate and
  make `bloc_test` assertions exact (`expect: () => [loading, success(...)]`).
- Immutable states + `const` constructors avoid accidental mutation and
  needless rebuilds.
- Cubit (methods, not events) is simple enough for this app's size while
  staying fully unit-testable via `bloc_test` + `mocktail`.

One deviation worth noting: `@freezed` classes in this project's resolved
freezed version (3.x) must be declared `abstract class X with _$X` (single
constructor) or `sealed class X with _$X` (multi-variant union) — a plain
`class X with _$X` fails to compile (`non_abstract_class_inherits_abstract_member`).
That's a freezed-version detail, not a deviation from the pattern above.

**The locked-lesson-tap effect:** rather than adding a `lockedLessonTapped`
state variant (which would replace the visible course-details content while
the sheet is shown), it's a nullable `lockedTap` field on
`CourseDetailsSuccess`. The page uses `BlocListener` with `listenWhen:
(p, c) => c is CourseDetailsSuccess && c.lockedTap != null` to show the
sheet once, then calls `clearLockedTap()`. Content stays visible underneath;
`bloc_test` still asserts the effect as an ordinary state transition.

## 7. Storage: Hive (database) + SharedPreferences (cache)

**Hive** (`progress` box, key = lessonId, value = `LessonProgressModel`'s
`toJson()`/`fromJson()` map): fast, offline, and naturally key-by-lessonId,
which is exactly how progress is looked up and unlocked. No Hive type
adapters or extra codegen — storing a plain `Map<String, dynamic>` and
round-tripping through the freezed model's own JSON methods is enough.

**SharedPreferences** (`locale`, `theme_mode`, `playback_speed`): three
primitive values with no query needs — SharedPreferences is the simplest
tool that fits, and pulling in Hive for three keys would be overhead.

Both sit behind a data source + repository (progress) or a data source
directly (settings — see the deviation below), so swapping either storage
mechanism later only touches its own feature.

**Deviation:** `SettingsCubit` calls `SettingsCacheDataSource` directly, with
no `domain/repositories` or `domain/usecases` layer — the original task
spec's own folder listing for `settings` omits them too. This breaks the
general "presentation only talks to use cases/domain services" rule for one
feature; three SharedPreferences primitives with no business logic on top
didn't seem to earn a repository + three single-method use cases. Also by
explicit choice, `SettingsCubit` and `CoursesCubit` are provided once at the
app root (`app.dart`), not scoped to their route — `CoursesCubit` needs to
survive `push`/`pop` to and from course details without reloading, and
having both reachable from anywhere via `context.read` keeps the DI/provider
setup simple for a task this size, at the cost of them technically
outliving the screen most closely associated with them.

## 8. Key rules (all in `ProgressCalculator`, pure Dart, no Flutter imports)

By explicit choice for this task, the completion threshold is **99%**, not
the commonly-suggested 90% — `ProgressCalculator.completionThreshold = 0.99`.
All rules below, the ARB strings, and the seek bar's completion tick read
from that one constant.

1. **Completion:** a lesson completes when `position >= 0.99 * duration`.
   Monotonic — `isCompletedGiven(wasCompleted, ...)` ORs the new check with
   the previous value, so it never reverts to false. `SavePositionUseCase`
   also takes an `isCompletedHint` from the cubit's own in-memory state and
   ORs it in, so a periodic position-save racing an in-flight
   `MarkCompletedUseCase` write can't undo a just-set completion by reading
   stale data.
2. **Sequential unlock:** lessons flattened across all sections in course
   order; lesson 0 always unlocked; lesson *n* unlocked only if lesson
   *n-1* is completed. `ProgressCalculator` only ever sees flattened lesson
   ids, never section structure, so "unlock across a section boundary" is
   automatic rather than a special case.
3. **Status:** `notStarted | inProgress | completed | locked`, derived from
   the flattened sequence above.
4. **Course progress %:** `completedLessons / totalLessons`, rounded; 0 for
   an empty course (no division by zero).
5. **Continue watching:** most-recently-updated `inProgress` lesson across
   all courses; hidden when there is none.
6. **Resume:** reopening a lesson seeks to the saved position, unless it's
   within the last 2 seconds of the video, in which case it restarts at 0.
7. **Next lesson:** enabled only if the current lesson is completed and a
   next lesson exists.
8. **Save cadence:** position is saved every 5 seconds while playing, and on
   pause / seek-end / `AppLifecycleState.paused` / cubit `close()`. Never on
   every frame. `PlayerCubit` also ORs in the platform's own
   `VideoPlayerValue.isCompleted` signal alongside the 99% check, since a
   very short clip's last reported position can land a few ms short of the
   threshold and would otherwise never fire completion.

`AppLifecycleState.paused` reaches `PlayerCubit` via the page's own
`WidgetsBindingObserver` (a Cubit has no lifecycle hooks of its own) calling
a plain `cubit.onAppPaused()` method — the cubit still owns the actual
`VideoPlayerController` lifecycle (init/listen/dispose) end to end.

## 9. Data: `assets/data/courses.json`

Two courses (anatomy-101, physiology-101), two sections each, 2-3 lessons
per section — matching the designs. Differences from the shape suggested in
the task, and why:

| Field | Change | Reason |
|---|---|---|
| `title`, `instructor` | `{ar, en}` object, not a single string | One JSON file needs to serve both locales; `LocalizedTextModel.resolve(languageCode)` falls back to `ar` when `en` is empty. |
| `id` (section/lesson) | Globally unique (`anatomy-101-l1`, not `l1`) | Progress is stored in Hive keyed by lesson id *across all courses*; a non-unique id would collide. |
| `durationSec` | Display-only, read before the video loads | The real duration from `VideoPlayerController` is the source of truth for the 99% rule, not this field. It's set to the *actual* length of the bundled sample clips (5s / 8s — see below), not a realistic lesson length, since durations meaningfully longer than the real clips would make every lesson tile show a duration the video can never live up to. |

Parsing is defensive: a malformed top-level JSON throws `FormatException`
→ `ParseFailure`; any other load failure (e.g. a missing asset file) →
`AssetFailure`; a single malformed course entry inside an otherwise-valid
list is skipped rather than failing the whole list; an empty/missing
`sections` or `lessons` array yields an empty list, never a crash.

**Video/image assets:** `assets/videos/lesson1.mp4` and `lesson2.mp4` are
real short CC-licensed clips (reused across all 9 lessons, as the task
explicitly allows): `lesson1.mp4` is MDN's `flower.mp4` sample (CC0),
`lesson2.mp4` is `rabbit320.mp4` from MDN's `learning-area` tutorial repo (a
Big Buck Bunny excerpt, CC BY). Course thumbnails (`assets/images/*.png`)
are small placeholder tiles generated locally (a colored badge + simple
icon in the app's own teal), since no real photography was provided —
`Image.asset`'s `errorBuilder` still falls back to a plain colored tile with
an icon if a thumbnail is ever missing entirely. Headings use **Readex Pro**
and body text uses **IBM Plex Sans Arabic**, both bundled from Google
Fonts' OFL-licensed GitHub repo as offline font assets (no `google_fonts`
runtime package, matching the "no network calls" constraint).

## 10. RTL decisions

- The custom seek bar (`RtlSeekBar`) fills from the layout's *start* edge —
  right in Arabic, left in English — computed from `Directionality.of(context)`,
  not assumed from locale.
- Playback time (`0:42 / 1:48`) and the "stopped at / remaining" line on the
  continue-watching card are always wrapped in `Directionality(textDirection:
  TextDirection.ltr, ...)` so digits never reverse in RTL.
- Back buttons use `BackButton()` / `Icons.arrow_back`, which Flutter mirrors
  automatically under RTL `Directionality` — no hard-coded left/right icon.

## 11. States & errors

- **Loading:** `skeletonizer`'s `Skeletonizer` wraps the *real* layout with
  placeholder data (a fake `CourseModel`) — no bespoke shimmer code, no bare
  `CircularProgressIndicator` for a list.
- **Empty:** `AppEmptyView`, reused for "no courses yet", "no search
  results" (kept as a `filteredCourses.isEmpty` check inside `success`
  rather than its own top-level state, so the search bar stays visible) and
  "no lessons in this course".
- **Failure:** `AppErrorView` with a retry button, backed by the specific
  `Failure` message from the repository.
- **Video failure specifically** does *not* use the page-level failure
  state — `PlayerState.failure` is reserved for the lesson/course/progress
  *lookup* failing. A bad video asset is a nullable `videoError` field
  (typed as `VideoFailure`) inside `PlayerReady`, so the title, status chip
  and Next Lesson card stay usable while only the video area shows the
  amber "تعذّر تشغيل الفيديو" card with retry — matching "the rest of the
  page stays usable, no red screens."

## 12. Trade-offs, known issues, what I'd do with more time

**The app was not launched during development** (skipped in this session by
explicit request) — everything below is verified by `flutter analyze` and
`flutter test` only, not by running it. Before relying on this build,
manually check at least: the speed picker (crashed before the fix in this
list), entering and exiting fullscreen including rotation restore, tapping a
locked lesson then "open the required lesson" from the sheet, the ar/en and
dark-mode toggles, resuming a reopened lesson, and completion on the ~5s
clip actually unlocking the next lesson.

- **Notes feature dropped.** The task listed it as a bonus; cut for scope.
- **`PlayerCubit`'s video lifecycle isn't covered by automated tests.** Its
  `loadLesson` failure path (no video touched) has a `bloc_test`, but the
  success path creates a real `VideoPlayerController`, which needs a fake
  `VideoPlayerPlatform` implementation to run in `flutter test` — a
  meaningful chunk of test-infrastructure work on its own. With more time
  this would be the first thing I'd add, together with actually running the
  app.
- **Refresh-on-return uses `context.push(...).then((_) => cubit.refresh())`**,
  not `RouteAware`/`RouteObserver`. This is simple and correct for the
  common path, but has one known edge case: if the user auto-advances from
  lesson *n* to lesson *n+1* via `pushReplacement` (Next Lesson card) and
  *then* backs out, the original `push()` Future (awaited by the course
  details page) resolves at the moment of the *first* `pushReplacement`,
  not when the user actually leaves the lesson screen — so the details
  page's silent refresh can fire a little early. `RouteAware.didPopNext`
  would close this gap correctly regardless of how many replacements
  happened underneath; I'd swap to it with more time.
- **get_it lifetimes matter here and are easy to get wrong**: `CourseDetailsCubit`
  and `PlayerCubit` are registered as **factories** (`registerFactory`), not
  singletons — each page visit gets its own instance that it can safely
  `close()` on dispose. `SettingsCubit` and `CoursesCubit` are singletons,
  provided once at the app root (§7). Registering the former two as
  singletons would hand a second visit an already-closed cubit, and any
  `emit()` on it would throw `StateError`.
- **With more time:** widget tests for the locked-lesson sheet and RTL
  layout (listed as bonus in the task), integration tests for the full
  watch → complete → unlock flow, and a fake `VideoPlayerPlatform` for
  `PlayerCubit`'s success-path tests.

## 13. Time spent

[5 hours]

## 14. task recording 
https://drive.google.com/file/d/1-9gSz0NI_TEZftSrG3EkXeEQQuIvYw0z/view?usp=sharing

## 14. APK 
https://drive.google.com/file/d/1HFbEJsewvjQ8Fz0mS08Agmv-KLp_uzXo/view?usp=sharing
