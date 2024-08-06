// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'instructor_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InstructorProfile _$InstructorProfileFromJson(Map<String, dynamic> json) =>
    InstructorProfile(
      id: json['id'] as String,
      userId: json['userId'] as String,
      fullName: json['fullName'] as String,
      title: json['title'] as String,
      profileImageUrl: json['profileImageUrl'] as String?,
    );

Map<String, dynamic> _$InstructorProfileToJson(InstructorProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'fullName': instance.fullName,
      'title': instance.title,
      'profileImageUrl': instance.profileImageUrl,
    };
