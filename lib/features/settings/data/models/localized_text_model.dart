import 'package:freezed_annotation/freezed_annotation.dart';

part 'localized_text_model.freezed.dart';
part 'localized_text_model.g.dart';

@freezed
class LocalizedTextModel with _$LocalizedTextModel {
  const LocalizedTextModel._();

  const factory LocalizedTextModel({
    required String ar,
    @Default('') String en,
  }) = _LocalizedTextModel;

  factory LocalizedTextModel.fromJson(Map<String, dynamic> json) =>
      _$LocalizedTextModelFromJson(json);

  /// Resolves the text for [languageCode], falling back to Arabic when the
  /// requested language has no translation.
  String resolve(String languageCode) {
    if (languageCode == 'en' && en.isNotEmpty) return en;
    return ar;
  }
}
