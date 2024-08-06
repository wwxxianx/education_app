import 'package:education_app/domain/model/course/course.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_favourite_course.g.dart';

@JsonSerializable()
class UserFavouriteCourse extends Equatable {
  final String userId;
  final String courseId;
  final Course course;
  final String createdAt;

  const UserFavouriteCourse({
    required this.userId,
    required this.courseId,
    required this.course,
    required this.createdAt,
  });

  factory UserFavouriteCourse.fromJson(Map<String, dynamic> json) =>
      _$UserFavouriteCourseFromJson(json);

  Map<String, dynamic> toJson() => _$UserFavouriteCourseToJson(this);
  
  @override
  List<Object?> get props => [
    userId,
    courseId,
    course,
    createdAt,
  ];
}
