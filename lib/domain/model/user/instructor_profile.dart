import 'package:json_annotation/json_annotation.dart';

part 'instructor_profile.g.dart';

@JsonSerializable()
class InstructorProfile {
  final String id;
  final String userId;
  final String fullName;
  final String title;
  final String? profileImageUrl;

  const InstructorProfile({
    required this.id,
    required this.userId,
    required this.fullName,
    required this.title,
    this.profileImageUrl,
  });

  factory InstructorProfile.fromJson(Map<String, dynamic> json) =>
      _$InstructorProfileFromJson(json);

  Map<String, dynamic> toJson() => _$InstructorProfileToJson(this);
}
