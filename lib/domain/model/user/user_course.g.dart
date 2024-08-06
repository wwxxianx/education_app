// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserCourse _$UserCourseFromJson(Map<String, dynamic> json) => UserCourse(
      id: json['id'] as String,
      userId: json['userId'] as String,
      courseId: json['courseId'] as String,
      course: Course.fromJson(json['course'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserCourseToJson(UserCourse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'courseId': instance.courseId,
      'course': instance.course,
    };
