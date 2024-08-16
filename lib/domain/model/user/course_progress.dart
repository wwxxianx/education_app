import 'package:education_app/domain/model/course/course.dart';
import 'package:json_annotation/json_annotation.dart';
part 'course_progress.g.dart';

@JsonSerializable()
class CourseProgress {
  final CourseSummary course;
  final CoursePart coursePart;
  final String startedAt;

  const CourseProgress({
    required this.course,
    required this.coursePart,
    required this.startedAt,
  });

  factory CourseProgress.fromJson(Map<String, dynamic> json) =>
      _$CourseProgressFromJson(json);

  Map<String, dynamic> toJson() => _$CourseProgressToJson(this);
}
