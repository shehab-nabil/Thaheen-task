// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ar locale. All the
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
  String get localeName => 'ar';

  static String m0(lessonTitle) => "أكمل: ${lessonTitle}";

  static String m1(instructor, sections, lessons) =>
      "${instructor} · ${sections} أقسام · ${lessons} دروس";

  static String m2(current, total) => "الدرس ${current} من ${total}";

  static String m3(current, total, section) =>
      "الدرس ${current} من ${total} · ${section}";

  static String m4(count) =>
      "${Intl.plural(count, zero: 'لا دروس', one: 'درس واحد', two: 'درسان', few: '${count} دروس', many: '${count} درساً', other: '${count} درس')}";

  static String m5(requiredLesson, lesson) =>
      "أكمل درس \"${requiredLesson}\" أولاً لفتح \"${lesson}\"";

  static String m6(requiredLesson) => "الانتقال إلى \"${requiredLesson}\"";

  static String m7(percent, completed, total) =>
      "${percent}% · ${completed} من ${total}";

  static String m8(percent) => "${percent}%";

  static String m9(number) => "القسم ${number}";

  static String m10(speed) => "${speed}x";

  static String m11(position, remaining) =>
      "توقفت عند ${position} / متبقٍ ${remaining}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "allCoursesTitle": MessageLookupByLibrary.simpleMessage("كل الدورات"),
    "appTitle": MessageLookupByLibrary.simpleMessage("ثاهين"),
    "autoCompleteHint": MessageLookupByLibrary.simpleMessage(
      "يكتمل تلقائياً عند مشاهدة 90%",
    ),
    "backToCourses": MessageLookupByLibrary.simpleMessage("العودة إلى الدورات"),
    "continueLessonButton": m0,
    "continueWatchingTitle": MessageLookupByLibrary.simpleMessage(
      "أكمل المشاهدة",
    ),
    "courseDetailsSubtitle": m1,
    "courseNotFound": MessageLookupByLibrary.simpleMessage(
      "لم يتم العثور على الدورة",
    ),
    "courseParseFailure": MessageLookupByLibrary.simpleMessage(
      "تعذر قراءة بيانات الدورة",
    ),
    "coursesGreeting": MessageLookupByLibrary.simpleMessage("أهلاً بك"),
    "coursesLoadError": MessageLookupByLibrary.simpleMessage(
      "تعذر تحميل الدورات",
    ),
    "coursesTitle": MessageLookupByLibrary.simpleMessage("دوراتي"),
    "emptyCourseTitle": MessageLookupByLibrary.simpleMessage(
      "لا توجد دروس بعد",
    ),
    "genericEmptyTitle": MessageLookupByLibrary.simpleMessage("لا يوجد محتوى"),
    "genericErrorTitle": MessageLookupByLibrary.simpleMessage("حدث خطأ ما"),
    "languageToggleTooltip": MessageLookupByLibrary.simpleMessage(
      "تبديل اللغة",
    ),
    "lessonOfTotal": m2,
    "lessonOfTotalWithSection": m3,
    "lessonsCount": m4,
    "lockedSheetBody": m5,
    "lockedSheetOk": MessageLookupByLibrary.simpleMessage("حسناً"),
    "lockedSheetOpenRequired": m6,
    "lockedSheetTitle": MessageLookupByLibrary.simpleMessage(
      "خطوة واحدة قبل هذا الدرس",
    ),
    "nextLessonLabel": MessageLookupByLibrary.simpleMessage("الدرس التالي"),
    "nextLessonLocked": MessageLookupByLibrary.simpleMessage(
      "يُفتح بعد إكمال 90% من هذا الدرس",
    ),
    "noCoursesYet": MessageLookupByLibrary.simpleMessage("لا توجد دورات بعد"),
    "noSearchResults": MessageLookupByLibrary.simpleMessage(
      "لا توجد نتائج مطابقة",
    ),
    "overallProgressLabel": m7,
    "percentLabel": m8,
    "progressCacheFailure": MessageLookupByLibrary.simpleMessage(
      "تعذر حفظ التقدم",
    ),
    "retry": MessageLookupByLibrary.simpleMessage("إعادة المحاولة"),
    "searchHint": MessageLookupByLibrary.simpleMessage("ابحث عن دورة أو مدرب"),
    "sectionNumberLabel": m9,
    "speedMultiplier": m10,
    "statusCompleted": MessageLookupByLibrary.simpleMessage("مكتمل"),
    "statusInProgress": MessageLookupByLibrary.simpleMessage("قيد المشاهدة"),
    "statusLocked": MessageLookupByLibrary.simpleMessage("مقفل"),
    "statusNotStarted": MessageLookupByLibrary.simpleMessage("لم يبدأ"),
    "stoppedAtRemaining": m11,
    "themeToggleTooltip": MessageLookupByLibrary.simpleMessage("تبديل المظهر"),
    "videoLoadError": MessageLookupByLibrary.simpleMessage(
      "تعذّر تشغيل الفيديو",
    ),
    "videoLoadErrorBody": MessageLookupByLibrary.simpleMessage(
      "ملف الدرس مفقود أو تالف. تقدّمك في الدورة محفوظ ولن يتأثر.",
    ),
  };
}
