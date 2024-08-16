// ignore_for_file: constant_identifier_names

import 'package:education_app/domain/model/course/course.dart';
import 'package:education_app/domain/model/user/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification.g.dart';

enum NotificationType {
  COURSE_VOUCHER,
  COURSE_ENROLLED,
  COURSE_UPDATE,
}

@JsonSerializable()
class NotificationModel {
  final String id;
  final String type;
  final String title;
  final String? description;
  final bool isRead;
  final Map<String, dynamic>? metadata;
  final UserModel? actor;
  final String entityId;
  final String createdAt;
  final CourseSummary? course;

  NotificationType get notificationType => NotificationType.values.byName(type);

  const NotificationModel({
    required this.id,
    required this.type,
    required this.title,
    required this.isRead,
    this.description,
    this.metadata,
    this.actor,
    required this.entityId,
    required this.createdAt,
    this.course,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);

  NotificationModel copyWith({
    String? id,
    String? type,
    String? title,
    String? description,
    bool? isRead,
    Map<String, dynamic>? metadata,
    UserModel? actor,
    String? entityId,
    String? createdAt,
    CourseSummary? course,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      description: description ?? this.description,
      isRead: isRead ?? this.isRead,
      metadata: metadata ?? this.metadata,
      actor: actor ?? this.actor,
      entityId: entityId ?? this.entityId,
      createdAt: createdAt ?? this.createdAt,
      course: course ?? this.course,
    );
  }

  static final samples = [
    NotificationModel(
      id: '1',
      type: 'CAMPAIGN_UPDATE',
      title: 'title',
      isRead: false,
      description: 'description',
      actor: UserModel.sample,
      entityId: '123',
      createdAt: '2024-05-16T08:21:57.324Z',
    ),
    NotificationModel(
      id: '1',
      type: 'CAMPAIGN_UPDATE',
      title: 'title',
      isRead: false,
      description: 'description',
      actor: UserModel.sample,
      entityId: '123',
      createdAt: '2024-05-16T08:21:57.324Z',
    ),
    NotificationModel(
      id: '1',
      isRead: false,
      type: 'CAMPAIGN_UPDATE',
      title: 'A lover donated RM500 to your fundraiser!',
      entityId: '123',
      createdAt: '2024-05-16T08:21:57.324Z',
    ),
    NotificationModel(
      id: '1',
      isRead: false,
      type: 'CAMPAIGN_UPDATE',
      title: 'A new comment to your fundraiser “Green Initiative”.',
      description: "Comment: “How can i donate to your fundraiser?”",
      entityId: '123',
      createdAt: '2024-05-16T08:21:57.324Z',
    ),
  ];
}
