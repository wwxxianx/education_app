// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseLevel _$CourseLevelFromJson(Map<String, dynamic> json) => CourseLevel(
      id: json['id'] as String,
      level: json['level'] as String,
    );

Map<String, dynamic> _$CourseLevelToJson(CourseLevel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'level': instance.level,
    };

CoursePart _$CoursePartFromJson(Map<String, dynamic> json) => CoursePart(
      id: json['id'] as String,
      order: (json['order'] as num).toInt(),
      title: json['title'] as String,
      isVideoIncluded: json['isVideoIncluded'] as bool,
      resourceUrl: json['resourceUrl'] as String,
    );

Map<String, dynamic> _$CoursePartToJson(CoursePart instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order': instance.order,
      'title': instance.title,
      'isVideoIncluded': instance.isVideoIncluded,
      'resourceUrl': instance.resourceUrl,
    };

CourseSection _$CourseSectionFromJson(Map<String, dynamic> json) =>
    CourseSection(
      id: json['id'] as String,
      order: (json['order'] as num).toInt(),
      title: json['title'] as String,
      parts: (json['course_parts'] as List<dynamic>)
          .map((e) => CoursePart.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CourseSectionToJson(CourseSection instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order': instance.order,
      'title': instance.title,
      'course_parts': instance.parts,
    };

Course _$CourseFromJson(Map<String, dynamic> json) => Course(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      level: CourseLevel.fromJson(json['levels'] as Map<String, dynamic>),
      status: json['status'] as String?,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      reviewRating: (json['reviewRating'] as num?)?.toDouble(),
      instructor: CourseInstructor.fromJson(
          json['course_instructors'] as Map<String, dynamic>),
      category:
          CourseCategory.fromJson(json['categories'] as Map<String, dynamic>),
      price: (json['price'] as num).toDouble(),
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      language: Language.fromJson(json['language'] as Map<String, dynamic>),
      topics:
          (json['topics'] as List<dynamic>).map((e) => e as String).toList(),
      requirements: (json['requirements'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      updates: (json['updates'] as List<dynamic>?)
              ?.map((e) => CourseUpdate.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      sections: (json['course_sections'] as List<dynamic>?)
              ?.map((e) => CourseSection.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      images: (json['course_images'] as List<dynamic>?)
              ?.map((e) => ImageModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      videoUrl: json['videoUrl'] as String?,
      reviews: (json['reviews'] as List<dynamic>?)
              ?.map((e) => UserReview.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$CourseToJson(Course instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'levels': instance.level,
      'status': instance.status,
      'thumbnailUrl': instance.thumbnailUrl,
      'course_instructors': instance.instructor,
      'categories': instance.category,
      'price': instance.price,
      'reviewRating': instance.reviewRating,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'language': instance.language,
      'topics': instance.topics,
      'requirements': instance.requirements,
      'course_images': instance.images,
      'videoUrl': instance.videoUrl,
      'updates': instance.updates,
      'course_sections': instance.sections,
      'reviews': instance.reviews,
    };

CourseUpdate _$CourseUpdateFromJson(Map<String, dynamic> json) => CourseUpdate(
      id: json['id'] as String,
      updateOverview: json['updateOverview'] as String,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$CourseUpdateToJson(CourseUpdate instance) =>
    <String, dynamic>{
      'id': instance.id,
      'updateOverview': instance.updateOverview,
      'createdAt': instance.createdAt,
    };
