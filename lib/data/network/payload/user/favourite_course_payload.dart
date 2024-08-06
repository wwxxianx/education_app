import 'package:json_annotation/json_annotation.dart';

part 'favourite_course_payload.g.dart';

@JsonSerializable()
class UserFavouriteCoursePayload {
  final String courseId;

  const UserFavouriteCoursePayload({
    required this.courseId,
  });

  factory UserFavouriteCoursePayload.fromJson(Map<String, dynamic> json) => _$UserFavouriteCoursePayloadFromJson(json);

  Map<String, dynamic> toJson() => _$UserFavouriteCoursePayloadToJson(this);
}