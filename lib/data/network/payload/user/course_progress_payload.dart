import 'package:json_annotation/json_annotation.dart';
part 'course_progress_payload.g.dart';

@JsonSerializable()
class CourseProgressPayload {
  final String partId;
  final String courseId;

  const CourseProgressPayload({required this.partId, required this.courseId});

  factory CourseProgressPayload.fromJson(Map<String, dynamic> json) =>
      _$CourseProgressPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$CourseProgressPayloadToJson(this);
}
