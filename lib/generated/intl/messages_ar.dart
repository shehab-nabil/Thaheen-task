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

  static String m0(percent) => "يكتمل تلقائياً عند مشاهدة ${percent}%";

  static String m1(lessonTitle) => "أكمل: ${lessonTitle}";

  static String m2(instructor, sectionsText, lessonsText) =>
      "${instructor} · ${sectionsText} · ${lessonsText}";

  static String m3(current, total) => "الدرس ${current} من ${total}";

  static String m4(current, total, section) =>
      "الدرس ${current} من ${total} · ${section}";

  static String m5(count) =>
      "${Intl.plural(count, zero: 'لا دروس', one: 'درس واحد', two: 'درسان', few: '${count} دروس', many: '${count} درساً', other: '${count} درس')}";

  static String m6(requiredLesson, lesson) =>
      "أكمل درس \"${requiredLesson}\" أولاً لفتح \"${lesson}\"";

  static String m7(requiredLesson) => "الانتقال إلى \"${requiredLesson}\"";

  static String m8(percent) => "يُفتح بعد إكمال ${percent}% من هذا الدرس";

  static String m9(percent, completed, total) =>
      "${percent}% · ${completed} من ${total}";

  static String m10(percent) => "${percent}%";

  static String m11(number) => "القسم ${number}";

  static String m12(count) =>
      "${Intl.plural(count, zero: 'لا أقسام', one: 'قسم واحد', two: 'قسمان', few: '${count} أقسام', many: '${count} قسماً', other: '${count} قسم')}";

  static String m13(speed) => "${speed}x";

  static String m14(position, remaining) =>
      "توقفت عند ${position} / متبقٍ ${remaining}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "allCoursesTitle": MessageLookupByLibrary.simpleMessage("كل الدورات"),
    "appTitle": MessageLookupByLibrary.simpleMessage("ذهين"),
    "autoCompleteHint": m0,
    "backToCourses": MessageLookupByLibrary.simpleMessage("العودة إلى الدورات"),
    "continueLessonButton": m1,
    "continueWatchingTitle": MessageLookupByLibrary.simpleMessage(
      "أكمل المشاهدة",
    ),
    "courseAssetMissing": MessageLookupByLibrary.simpleMessage(
      "ملف بيانات الدورات غير موجود",
    ),
    "courseDetailsSubtitle": m2,
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
    "lessonOfTotal": m3,
    "lessonOfTotalWithSection": m4,
    "lessonsCount": m5,
    "lockedSheetBody": m6,
    "lockedSheetOk": MessageLookupByLibrary.simpleMessage("حسناً"),
    "lockedSheetOpenRequired": m7,
    "lockedSheetTitle": MessageLookupByLibrary.simpleMessage(
      "خطوة واحدة قبل هذا الدرس",
    ),
    "nextLessonLabel": MessageLookupByLibrary.simpleMessage("الدرس التالي"),
    "nextLessonLocked": m8,
    "noCoursesYet": MessageLookupByLibrary.simpleMessage("لا توجد دورات بعد"),
    "noSearchResults": MessageLookupByLibrary.simpleMessage(
      "لا توجد نتائج مطابقة",
    ),
    "overallProgressLabel": m9,
    "percentLabel": m10,
    "progressCacheFailure": MessageLookupByLibrary.simpleMessage(
      "تعذر حفظ التقدم",
    ),
    "retry": MessageLookupByLibrary.simpleMessage("إعادة المحاولة"),
    "searchHint": MessageLookupByLibrary.simpleMessage("ابحث عن دورة أو مدرب"),
    "sectionNumberLabel": m11,
    "sectionsCount": m12,
    "speedMultiplier": m13,
    "statusCompleted": MessageLookupByLibrary.simpleMessage("مكتمل"),
    "statusInProgress": MessageLookupByLibrary.simpleMessage("قيد المشاهدة"),
    "statusLocked": MessageLookupByLibrary.simpleMessage("مقفل"),
    "statusNotStarted": MessageLookupByLibrary.simpleMessage("لم يبدأ"),
    "stoppedAtRemaining": m14,
    "themeToggleTooltip": MessageLookupByLibrary.simpleMessage("تبديل المظهر"),
    "videoLoadError": MessageLookupByLibrary.simpleMessage(
      "تعذّر تشغيل الفيديو",
    ),
    "videoLoadErrorBody": MessageLookupByLibrary.simpleMessage(
      "ملف الدرس مفقود أو تالف. تقدّمك في الدورة محفوظ ولن يتأثر.",
    ),
  };
}
