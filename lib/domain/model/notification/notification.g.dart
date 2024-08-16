// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      id: json['id'] as String,
      type: json['type'] as String,
      title: json['title'] as String,
      isRead: json['isRead'] as bool,
      description: json['description'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
      actor: json['actor'] == null
          ? null
          : UserModel.fromJson(json['actor'] as Map<String, dynamic>),
      entityId: json['entityId'] as String,
      createdAt: json['createdAt'] as String,
      course: json['course'] == null
          ? null
          : CourseSummary.fromJson(json['course'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'title': instance.title,
      'description': instance.description,
      'isRead': instance.isRead,
      'metadata': instance.metadata,
      'actor': instance.actor,
      'entityId': instance.entityId,
      'createdAt': instance.createdAt,
      'course': instance.course,
    };
