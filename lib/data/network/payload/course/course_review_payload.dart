import 'package:json_annotation/json_annotation.dart';

part 'course_review_payload.g.dart';

@JsonSerializable()
class CourseReviewPayload {
  final String courseId;
  final String reviewContent;
  final int reviewRating;

  const CourseReviewPayload({
    required this.courseId,
    required this.reviewContent,
    required this.reviewRating,
  });

  factory CourseReviewPayload.fromJson(Map<String, dynamic> json) =>
      _$CourseReviewPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$CourseReviewPayloadToJson(this);
}
