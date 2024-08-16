// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_preference.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPreference _$UserPreferenceFromJson(Map<String, dynamic> json) =>
    UserPreference(
      id: json['id'] as String,
      favouriteCourseCategories:
          (json['favouriteCourseCategories'] as List<dynamic>)
              .map((e) => CourseCategory.fromJson(e as Map<String, dynamic>))
              .toList(),
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );

Map<String, dynamic> _$UserPreferenceToJson(UserPreference instance) =>
    <String, dynamic>{
      'id': instance.id,
      'favouriteCourseCategories': instance.favouriteCourseCategories,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
