// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommended_course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecommendedCourse _$RecommendedCourseFromJson(Map<String, dynamic> json) =>
    RecommendedCourse(
      recommendedCourses: (json['recommendedCourses'] as List<dynamic>?)
              ?.map((e) => Course.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$RecommendedCourseToJson(RecommendedCourse instance) =>
    <String, dynamic>{
      'recommendedCourses': instance.recommendedCourses,
    };

RecommendedCourseFromPurchaseHistory
    _$RecommendedCourseFromPurchaseHistoryFromJson(Map<String, dynamic> json) =>
        RecommendedCourseFromPurchaseHistory(
          recommendedCourses: (json['recommendedCourses'] as List<dynamic>?)
                  ?.map((e) => Course.fromJson(e as Map<String, dynamic>))
                  .toList() ??
              const [],
          latestPurchase: json['latestPurchase'] == null
              ? null
              : CourseSummary.fromJson(
                  json['latestPurchase'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$RecommendedCourseFromPurchaseHistoryToJson(
        RecommendedCourseFromPurchaseHistory instance) =>
    <String, dynamic>{
      'recommendedCourses': instance.recommendedCourses,
      'latestPurchase': instance.latestPurchase,
    };
