import 'package:education_app/domain/model/course/course.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_course.g.dart';

@JsonSerializable()
class UserCourse {
  final String id;
  final String userId;
  final String courseId;
  final Course course;

  const UserCourse({
    required this.id,
    required this.userId,
    required this.courseId,
    required this.course,
  });

  factory UserCourse.fromJson(Map<String, dynamic> json) =>
      _$UserCourseFromJson(json);

  Map<String, dynamic> toJson() => _$UserCourseToJson(this);
}
