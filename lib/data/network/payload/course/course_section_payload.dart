import 'dart:io';

import 'package:json_annotation/json_annotation.dart';

part 'course_section_payload.g.dart';

@JsonSerializable()
class UpdateCourseSectionPayload {
  final String sectionId;
  final String title;

  const UpdateCourseSectionPayload({
    required this.sectionId,
    required this.title,
  });

  factory UpdateCourseSectionPayload.fromJson(Map<String, dynamic> json) =>
      _$UpdateCourseSectionPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateCourseSectionPayloadToJson(this);
}

class CreateCourseSectionPayload {
  final String courseId;
  final String title;
  final List<String> coursePartsTitle;
  final List<File> resourceFiles;

  const CreateCourseSectionPayload(
      {required this.courseId,
      required this.title,
      this.coursePartsTitle = const [],
      this.resourceFiles = const [],});
}
