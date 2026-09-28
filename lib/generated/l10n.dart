// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `ذهين`
  String get appTitle {
    return Intl.message('ذهين', name: 'appTitle', desc: '', args: []);
  }

  /// `أهلاً بك`
  String get coursesGreeting {
    return Intl.message(
      'أهلاً بك',
      name: 'coursesGreeting',
      desc: '',
      args: [],
    );
  }

  /// `دوراتي`
  String get coursesTitle {
    return Intl.message('دوراتي', name: 'coursesTitle', desc: '', args: []);
  }

  /// `ابحث عن دورة أو مدرب`
  String get searchHint {
    return Intl.message(
      'ابحث عن دورة أو مدرب',
      name: 'searchHint',
      desc: '',
      args: [],
    );
  }

  /// `تبديل اللغة`
  String get languageToggleTooltip {
    return Intl.message(
      'تبديل اللغة',
      name: 'languageToggleTooltip',
      desc: '',
      args: [],
    );
  }

  /// `تبديل المظهر`
  String get themeToggleTooltip {
    return Intl.message(
      'تبديل المظهر',
      name: 'themeToggleTooltip',
      desc: '',
      args: [],
    );
  }

  /// `أكمل المشاهدة`
  String get continueWatchingTitle {
    return Intl.message(
      'أكمل المشاهدة',
      name: 'continueWatchingTitle',
      desc: '',
      args: [],
    );
  }

  /// `الدرس {current} من {total}`
  String lessonOfTotal(int current, int total) {
    return Intl.message(
      'الدرس $current من $total',
      name: 'lessonOfTotal',
      desc: '',
      args: [current, total],
    );
  }

  /// `توقفت عند {position} / متبقٍ {remaining}`
  String stoppedAtRemaining(String position, String remaining) {
    return Intl.message(
      'توقفت عند $position / متبقٍ $remaining',
      name: 'stoppedAtRemaining',
      desc: '',
      args: [position, remaining],
    );
  }

  /// `كل الدورات`
  String get allCoursesTitle {
    return Intl.message(
      'كل الدورات',
      name: 'allCoursesTitle',
      desc: '',
      args: [],
    );
  }

  /// `{count, plural, =0{لا دروس} =1{درس واحد} =2{درسان} few{{count} دروس} many{{count} درساً} other{{count} درس}}`
  String lessonsCount(int count) {
    return Intl.plural(
      count,
      zero: 'لا دروس',
      one: 'درس واحد',
      two: 'درسان',
      few: '$count دروس',
      many: '$count درساً',
      other: '$count درس',
      name: 'lessonsCount',
      desc: '',
      args: [count],
    );
  }

  /// `{percent}%`
  String percentLabel(int percent) {
    return Intl.message(
      '$percent%',
      name: 'percentLabel',
      desc: '',
      args: [percent],
    );
  }

  /// `إعادة المحاولة`
  String get retry {
    return Intl.message('إعادة المحاولة', name: 'retry', desc: '', args: []);
  }

  /// `تعذر تحميل الدورات`
  String get coursesLoadError {
    return Intl.message(
      'تعذر تحميل الدورات',
      name: 'coursesLoadError',
      desc: '',
      args: [],
    );
  }

  /// `لا توجد دورات بعد`
  String get noCoursesYet {
    return Intl.message(
      'لا توجد دورات بعد',
      name: 'noCoursesYet',
      desc: '',
      args: [],
    );
  }

  /// `لا توجد نتائج مطابقة`
  String get noSearchResults {
    return Intl.message(
      'لا توجد نتائج مطابقة',
      name: 'noSearchResults',
      desc: '',
      args: [],
    );
  }

  /// `حدث خطأ ما`
  String get genericErrorTitle {
    return Intl.message(
      'حدث خطأ ما',
      name: 'genericErrorTitle',
      desc: '',
      args: [],
    );
  }

  /// `لا يوجد محتوى`
  String get genericEmptyTitle {
    return Intl.message(
      'لا يوجد محتوى',
      name: 'genericEmptyTitle',
      desc: '',
      args: [],
    );
  }

  /// `{instructor} · {sectionsText} · {lessonsText}`
  String courseDetailsSubtitle(
    String instructor,
    String sectionsText,
    String lessonsText,
  ) {
    return Intl.message(
      '$instructor · $sectionsText · $lessonsText',
      name: 'courseDetailsSubtitle',
      desc: '',
      args: [instructor, sectionsText, lessonsText],
    );
  }

  /// `{count, plural, =0{لا أقسام} =1{قسم واحد} =2{قسمان} few{{count} أقسام} many{{count} قسماً} other{{count} قسم}}`
  String sectionsCount(int count) {
    return Intl.plural(
      count,
      zero: 'لا أقسام',
      one: 'قسم واحد',
      two: 'قسمان',
      few: '$count أقسام',
      many: '$count قسماً',
      other: '$count قسم',
      name: 'sectionsCount',
      desc: '',
      args: [count],
    );
  }

  /// `{percent}% · {completed} من {total}`
  String overallProgressLabel(int percent, int completed, int total) {
    return Intl.message(
      '$percent% · $completed من $total',
      name: 'overallProgressLabel',
      desc: '',
      args: [percent, completed, total],
    );
  }

  /// `القسم {number}`
  String sectionNumberLabel(int number) {
    return Intl.message(
      'القسم $number',
      name: 'sectionNumberLabel',
      desc: '',
      args: [number],
    );
  }

  /// `مكتمل`
  String get statusCompleted {
    return Intl.message('مكتمل', name: 'statusCompleted', desc: '', args: []);
  }

  /// `قيد المشاهدة`
  String get statusInProgress {
    return Intl.message(
      'قيد المشاهدة',
      name: 'statusInProgress',
      desc: '',
      args: [],
    );
  }

  /// `لم يبدأ`
  String get statusNotStarted {
    return Intl.message(
      'لم يبدأ',
      name: 'statusNotStarted',
      desc: '',
      args: [],
    );
  }

  /// `مقفل`
  String get statusLocked {
    return Intl.message('مقفل', name: 'statusLocked', desc: '', args: []);
  }

  /// `أكمل: {lessonTitle}`
  String continueLessonButton(String lessonTitle) {
    return Intl.message(
      'أكمل: $lessonTitle',
      name: 'continueLessonButton',
      desc: '',
      args: [lessonTitle],
    );
  }

  /// `خطوة واحدة قبل هذا الدرس`
  String get lockedSheetTitle {
    return Intl.message(
      'خطوة واحدة قبل هذا الدرس',
      name: 'lockedSheetTitle',
      desc: '',
      args: [],
    );
  }

  /// `أكمل درس "{requiredLesson}" أولاً لفتح "{lesson}"`
  String lockedSheetBody(String requiredLesson, String lesson) {
    return Intl.message(
      'أكمل درس "$requiredLesson" أولاً لفتح "$lesson"',
      name: 'lockedSheetBody',
      desc: '',
      args: [requiredLesson, lesson],
    );
  }

  /// `الانتقال إلى "{requiredLesson}"`
  String lockedSheetOpenRequired(String requiredLesson) {
    return Intl.message(
      'الانتقال إلى "$requiredLesson"',
      name: 'lockedSheetOpenRequired',
      desc: '',
      args: [requiredLesson],
    );
  }

  /// `حسناً`
  String get lockedSheetOk {
    return Intl.message('حسناً', name: 'lockedSheetOk', desc: '', args: []);
  }

  /// `لا توجد دروس بعد`
  String get emptyCourseTitle {
    return Intl.message(
      'لا توجد دروس بعد',
      name: 'emptyCourseTitle',
      desc: '',
      args: [],
    );
  }

  /// `العودة إلى الدورات`
  String get backToCourses {
    return Intl.message(
      'العودة إلى الدورات',
      name: 'backToCourses',
      desc: '',
      args: [],
    );
  }

  /// `الدرس {current} من {total} · {section}`
  String lessonOfTotalWithSection(int current, int total, String section) {
    return Intl.message(
      'الدرس $current من $total · $section',
      name: 'lessonOfTotalWithSection',
      desc: '',
      args: [current, total, section],
    );
  }

  /// `يكتمل تلقائياً عند مشاهدة {percent}%`
  String autoCompleteHint(int percent) {
    return Intl.message(
      'يكتمل تلقائياً عند مشاهدة $percent%',
      name: 'autoCompleteHint',
      desc: '',
      args: [percent],
    );
  }

  /// `يُفتح بعد إكمال {percent}% من هذا الدرس`
  String nextLessonLocked(int percent) {
    return Intl.message(
      'يُفتح بعد إكمال $percent% من هذا الدرس',
      name: 'nextLessonLocked',
      desc: '',
      args: [percent],
    );
  }

  /// `الدرس التالي`
  String get nextLessonLabel {
    return Intl.message(
      'الدرس التالي',
      name: 'nextLessonLabel',
      desc: '',
      args: [],
    );
  }

  /// `تعذّر تشغيل الفيديو`
  String get videoLoadError {
    return Intl.message(
      'تعذّر تشغيل الفيديو',
      name: 'videoLoadError',
      desc: '',
      args: [],
    );
  }

  /// `ملف الدرس مفقود أو تالف. تقدّمك في الدورة محفوظ ولن يتأثر.`
  String get videoLoadErrorBody {
    return Intl.message(
      'ملف الدرس مفقود أو تالف. تقدّمك في الدورة محفوظ ولن يتأثر.',
      name: 'videoLoadErrorBody',
      desc: '',
      args: [],
    );
  }

  /// `{speed}x`
  String speedMultiplier(String speed) {
    return Intl.message(
      '${speed}x',
      name: 'speedMultiplier',
      desc: '',
      args: [speed],
    );
  }

  /// `تعذر قراءة بيانات الدورة`
  String get courseParseFailure {
    return Intl.message(
      'تعذر قراءة بيانات الدورة',
      name: 'courseParseFailure',
      desc: '',
      args: [],
    );
  }

  /// `ملف بيانات الدورات غير موجود`
  String get courseAssetMissing {
    return Intl.message(
      'ملف بيانات الدورات غير موجود',
      name: 'courseAssetMissing',
      desc: '',
      args: [],
    );
  }

  /// `تعذر حفظ التقدم`
  String get progressCacheFailure {
    return Intl.message(
      'تعذر حفظ التقدم',
      name: 'progressCacheFailure',
      desc: '',
      args: [],
    );
  }

  /// `لم يتم العثور على الدورة`
  String get courseNotFound {
    return Intl.message(
      'لم يتم العثور على الدورة',
      name: 'courseNotFound',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
