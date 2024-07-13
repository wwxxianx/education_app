// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_instructor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseInstructor _$CourseInstructorFromJson(Map<String, dynamic> json) =>
    CourseInstructor(
      id: json['id'] as String,
      fullName: json['fullName'] as String,
      title: json['title'] as String?,
      profileImageUrl: json['profileImageUrl'] as String?,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$CourseInstructorToJson(CourseInstructor instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'title': instance.title,
      'profileImageUrl': instance.profileImageUrl,
      'createdAt': instance.createdAt,
    };
