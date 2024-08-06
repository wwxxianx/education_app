// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_favourite_course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserFavouriteCourse _$UserFavouriteCourseFromJson(Map<String, dynamic> json) =>
    UserFavouriteCourse(
      userId: json['userId'] as String,
      courseId: json['courseId'] as String,
      course: Course.fromJson(json['course'] as Map<String, dynamic>),
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$UserFavouriteCourseToJson(
        UserFavouriteCourse instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'courseId': instance.courseId,
      'course': instance.course,
      'createdAt': instance.createdAt,
    };
