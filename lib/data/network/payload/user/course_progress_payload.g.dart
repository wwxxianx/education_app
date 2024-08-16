// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_progress_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseProgressPayload _$CourseProgressPayloadFromJson(
        Map<String, dynamic> json) =>
    CourseProgressPayload(
      partId: json['partId'] as String,
      courseId: json['courseId'] as String,
    );

Map<String, dynamic> _$CourseProgressPayloadToJson(
        CourseProgressPayload instance) =>
    <String, dynamic>{
      'partId': instance.partId,
      'courseId': instance.courseId,
    };
