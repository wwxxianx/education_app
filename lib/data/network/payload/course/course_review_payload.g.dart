// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_review_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseReviewPayload _$CourseReviewPayloadFromJson(Map<String, dynamic> json) =>
    CourseReviewPayload(
      courseId: json['courseId'] as String,
      reviewContent: json['reviewContent'] as String,
      reviewRating: (json['reviewRating'] as num).toInt(),
    );

Map<String, dynamic> _$CourseReviewPayloadToJson(
        CourseReviewPayload instance) =>
    <String, dynamic>{
      'courseId': instance.courseId,
      'reviewContent': instance.reviewContent,
      'reviewRating': instance.reviewRating,
    };
