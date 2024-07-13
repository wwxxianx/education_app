// ignore_for_file: constant_identifier_names

import 'package:education_app/common/widgets/container/chip.dart';

enum CoursePublishStatus {
  DRAFT,
  PUBLISHED,
  UNDER_REVIEW,
}

extension CoursePublishStatusExtension on CoursePublishStatus {
  String get displayStatus {
    switch (this) {
      case CoursePublishStatus.DRAFT:
        return "Draft";
      case CoursePublishStatus.PUBLISHED:
        return "Published";
      case CoursePublishStatus.UNDER_REVIEW:
        return "Review";
    }
  }

  CustomChipStyle get chipStyle {
    switch (this) {
      case CoursePublishStatus.DRAFT:
        return CustomChipStyle.slate;
      case CoursePublishStatus.PUBLISHED:
        return CustomChipStyle.green;
      case CoursePublishStatus.UNDER_REVIEW:
        return CustomChipStyle.amber;
    }
  }
}

enum CourseLevelEnum {
  BEGINNER,
  INTERMEDIATE,
  EXPERT,
}
