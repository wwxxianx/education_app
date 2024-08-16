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

CourseResource _$CourseResourceFromJson(Map<String, dynamic> json) =>
    CourseResource(
      id: json['id'] as String,
      url: json['url'] as String,
      mimeType: json['mimeType'] as String,
    );

Map<String, dynamic> _$CourseResourceToJson(CourseResource instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'mimeType': instance.mimeType,
    };

CoursePart _$CoursePartFromJson(Map<String, dynamic> json) => CoursePart(
      id: json['id'] as String,
      order: (json['order'] as num).toInt(),
      title: json['title'] as String,
      resource:
          CourseResource.fromJson(json['resource'] as Map<String, dynamic>),
      courseSectionId: json['courseSectionId'] as String,
    );

Map<String, dynamic> _$CoursePartToJson(CoursePart instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order': instance.order,
      'title': instance.title,
      'resource': instance.resource,
      'courseSectionId': instance.courseSectionId,
    };

CourseSection _$CourseSectionFromJson(Map<String, dynamic> json) =>
    CourseSection(
      id: json['id'] as String,
      order: (json['order'] as num).toInt(),
      title: json['title'] as String,
      parts: (json['parts'] as List<dynamic>?)
              ?.map((e) => CoursePart.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$CourseSectionToJson(CourseSection instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order': instance.order,
      'title': instance.title,
      'parts': instance.parts,
    };

Course _$CourseFromJson(Map<String, dynamic> json) => Course(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      level: CourseLevel.fromJson(json['level'] as Map<String, dynamic>),
      instructor:
          UserModel.fromJson(json['instructor'] as Map<String, dynamic>),
      status: json['status'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      reviewRating: (json['reviewRating'] as num).toDouble(),
      category:
          CourseCategory.fromJson(json['category'] as Map<String, dynamic>),
      subcategories: (json['subcategories'] as List<dynamic>?)
              ?.map((e) => CourseCategory.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      price: (json['price'] as num).toInt(),
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
      sections: (json['sections'] as List<dynamic>?)
              ?.map((e) => CourseSection.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      images: (json['images'] as List<dynamic>?)
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
      'level': instance.level,
      'status': instance.status,
      'thumbnailUrl': instance.thumbnailUrl,
      'category': instance.category,
      'subcategories': instance.subcategories,
      'instructor': instance.instructor,
      'price': instance.price,
      'reviewRating': instance.reviewRating,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'language': instance.language,
      'topics': instance.topics,
      'requirements': instance.requirements,
      'images': instance.images,
      'videoUrl': instance.videoUrl,
      'updates': instance.updates,
      'sections': instance.sections,
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

CourseSummary _$CourseSummaryFromJson(Map<String, dynamic> json) =>
    CourseSummary(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      price: (json['price'] as num).toInt(),
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      videoUrl: json['videoUrl'] as String?,
    );

Map<String, dynamic> _$CourseSummaryToJson(CourseSummary instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'thumbnailUrl': instance.thumbnailUrl,
      'price': instance.price,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'videoUrl': instance.videoUrl,
    };
