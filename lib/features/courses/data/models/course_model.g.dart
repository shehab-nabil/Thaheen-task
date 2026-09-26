// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CourseModel _$CourseModelFromJson(Map<String, dynamic> json) => _CourseModel(
  id: json['id'] as String,
  title: LocalizedTextModel.fromJson(json['title'] as Map<String, dynamic>),
  instructor: LocalizedTextModel.fromJson(
    json['instructor'] as Map<String, dynamic>,
  ),
  thumbnail: json['thumbnail'] as String,
  sections: (json['sections'] as List<dynamic>)
      .map((e) => SectionModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$CourseModelToJson(_CourseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'instructor': instance.instructor,
      'thumbnail': instance.thumbnail,
      'sections': instance.sections,
    };
