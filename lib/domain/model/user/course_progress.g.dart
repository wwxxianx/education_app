// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_progress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseProgress _$CourseProgressFromJson(Map<String, dynamic> json) =>
    CourseProgress(
      course: CourseSummary.fromJson(json['course'] as Map<String, dynamic>),
      coursePart:
          CoursePart.fromJson(json['coursePart'] as Map<String, dynamic>),
      startedAt: json['startedAt'] as String,
    );

Map<String, dynamic> _$CourseProgressToJson(CourseProgress instance) =>
    <String, dynamic>{
      'course': instance.course,
      'coursePart': instance.coursePart,
      'startedAt': instance.startedAt,
    };
