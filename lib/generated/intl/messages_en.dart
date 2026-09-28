// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(percent) => "Completes automatically at ${percent}% watched";

  static String m1(lessonTitle) => "Continue: ${lessonTitle}";

  static String m2(instructor, sectionsText, lessonsText) =>
      "${instructor} · ${sectionsText} · ${lessonsText}";

  static String m3(current, total) => "Lesson ${current} of ${total}";

  static String m4(current, total, section) =>
      "Lesson ${current} of ${total} · ${section}";

  static String m5(count) =>
      "${Intl.plural(count, zero: 'No lessons', one: '${count} lesson', other: '${count} lessons')}";

  static String m6(requiredLesson, lesson) =>
      "Finish \"${requiredLesson}\" first to unlock \"${lesson}\"";

  static String m7(requiredLesson) => "Go to \"${requiredLesson}\"";

  static String m8(percent) =>
      "Unlocks after completing ${percent}% of this lesson";

  static String m9(percent, completed, total) =>
      "${percent}% · ${completed} of ${total}";

  static String m10(percent) => "${percent}%";

  static String m11(number) => "Section ${number}";

  static String m12(count) =>
      "${Intl.plural(count, zero: 'No sections', one: '${count} section', other: '${count} sections')}";

  static String m13(speed) => "${speed}x";

  static String m14(position, remaining) =>
      "Stopped at ${position} / ${remaining} left";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "allCoursesTitle": MessageLookupByLibrary.simpleMessage("All Courses"),
    "appTitle": MessageLookupByLibrary.simpleMessage("Thaheen"),
    "autoCompleteHint": m0,
    "backToCourses": MessageLookupByLibrary.simpleMessage("Back to courses"),
    "continueLessonButton": m1,
    "continueWatchingTitle": MessageLookupByLibrary.simpleMessage(
      "Continue Watching",
    ),
    "courseAssetMissing": MessageLookupByLibrary.simpleMessage(
      "Course data file is missing",
    ),
    "courseDetailsSubtitle": m2,
    "courseNotFound": MessageLookupByLibrary.simpleMessage("Course not found"),
    "courseParseFailure": MessageLookupByLibrary.simpleMessage(
      "Couldn\'t read course data",
    ),
    "coursesGreeting": MessageLookupByLibrary.simpleMessage("Welcome back"),
    "coursesLoadError": MessageLookupByLibrary.simpleMessage(
      "Couldn\'t load courses",
    ),
    "coursesTitle": MessageLookupByLibrary.simpleMessage("My Courses"),
    "emptyCourseTitle": MessageLookupByLibrary.simpleMessage("No lessons yet"),
    "genericEmptyTitle": MessageLookupByLibrary.simpleMessage(
      "Nothing here yet",
    ),
    "genericErrorTitle": MessageLookupByLibrary.simpleMessage(
      "Something went wrong",
    ),
    "languageToggleTooltip": MessageLookupByLibrary.simpleMessage(
      "Switch language",
    ),
    "lessonOfTotal": m3,
    "lessonOfTotalWithSection": m4,
    "lessonsCount": m5,
    "lockedSheetBody": m6,
    "lockedSheetOk": MessageLookupByLibrary.simpleMessage("OK"),
    "lockedSheetOpenRequired": m7,
    "lockedSheetTitle": MessageLookupByLibrary.simpleMessage(
      "One step before this lesson",
    ),
    "nextLessonLabel": MessageLookupByLibrary.simpleMessage("Next Lesson"),
    "nextLessonLocked": m8,
    "noCoursesYet": MessageLookupByLibrary.simpleMessage("No courses yet"),
    "noSearchResults": MessageLookupByLibrary.simpleMessage(
      "No matching results",
    ),
    "overallProgressLabel": m9,
    "percentLabel": m10,
    "progressCacheFailure": MessageLookupByLibrary.simpleMessage(
      "Couldn\'t save progress",
    ),
    "retry": MessageLookupByLibrary.simpleMessage("Retry"),
    "searchHint": MessageLookupByLibrary.simpleMessage(
      "Search a course or instructor",
    ),
    "sectionNumberLabel": m11,
    "sectionsCount": m12,
    "speedMultiplier": m13,
    "statusCompleted": MessageLookupByLibrary.simpleMessage("Completed"),
    "statusInProgress": MessageLookupByLibrary.simpleMessage("In Progress"),
    "statusLocked": MessageLookupByLibrary.simpleMessage("Locked"),
    "statusNotStarted": MessageLookupByLibrary.simpleMessage("Not Started"),
    "stoppedAtRemaining": m14,
    "themeToggleTooltip": MessageLookupByLibrary.simpleMessage("Switch theme"),
    "videoLoadError": MessageLookupByLibrary.simpleMessage(
      "Couldn\'t play the video",
    ),
    "videoLoadErrorBody": MessageLookupByLibrary.simpleMessage(
      "The lesson file is missing or corrupted. Your course progress is saved and unaffected.",
    ),
  };
}
