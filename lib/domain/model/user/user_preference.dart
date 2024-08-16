import 'package:education_app/domain/model/course_category/course_category.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_preference.g.dart';

@JsonSerializable()
class UserPreference {
  final String id;
  final List<CourseCategory> favouriteCourseCategories;
  final String createdAt;
  final String updatedAt;

  const UserPreference({
    required this.id,
    required this.favouriteCourseCategories,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserPreference.fromJson(Map<String, dynamic> json) =>
      _$UserPreferenceFromJson(json);

  Map<String, dynamic> toJson() => _$UserPreferenceToJson(this);
}
