// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_section_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateCourseSectionPayload _$UpdateCourseSectionPayloadFromJson(
        Map<String, dynamic> json) =>
    UpdateCourseSectionPayload(
      sectionId: json['sectionId'] as String,
      title: json['title'] as String,
    );

Map<String, dynamic> _$UpdateCourseSectionPayloadToJson(
        UpdateCourseSectionPayload instance) =>
    <String, dynamic>{
      'sectionId': instance.sectionId,
      'title': instance.title,
    };
