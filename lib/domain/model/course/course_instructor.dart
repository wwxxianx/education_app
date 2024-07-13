import 'package:json_annotation/json_annotation.dart';

part 'course_instructor.g.dart';

@JsonSerializable()
class CourseInstructor {
  final String id;
  final String fullName;
  final String? title;
  final String? profileImageUrl;
  final String createdAt;

  const CourseInstructor({
    required this.id,
    required this.fullName,
    this.title,
    this.profileImageUrl,
    required this.createdAt,
  });

  factory CourseInstructor.fromJson(Map<String, dynamic> json) =>
      _$CourseInstructorFromJson(json);

  Map<String, dynamic> toJson() => _$CourseInstructorToJson(this);

  static const samples = [
    CourseInstructor(
      id: '1',
      fullName: 'Dr. Angela Yu',
      createdAt: '',
    ),
  ];
}
