// ignore_for_file: constant_identifier_names

import 'package:education_app/common/widgets/container/chip.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

enum CoursePublishStatus {
  DRAFT,
  PUBLISHED,
  UNDER_REVIEW;

  @override
  String toString() {
    switch (this) {
      case CoursePublishStatus.DRAFT:
        return "DRAFT";
      case CoursePublishStatus.PUBLISHED:
        return "PUBLISHED";
      case CoursePublishStatus.UNDER_REVIEW:
        return "UNDER_REVIEW";
    }
  }
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

  Widget buildStatusChip() {
    switch (this) {
      case CoursePublishStatus.DRAFT:
        return CustomChip(style: chipStyle, child: Text(displayStatus));
      case CoursePublishStatus.PUBLISHED:
        return CustomChip(style: chipStyle, child: Text(displayStatus));
      case CoursePublishStatus.UNDER_REVIEW:
        return CustomChip(style: chipStyle, child: Text(displayStatus));
    }
  }
}

enum CourseLevelEnum {
  BEGINNER,
  INTERMEDIATE,
  EXPERT,
}

enum CourseResourceMimeType {
  DOCUMENT,
  VIDEO,
  TEXT,
}

extension CourseResourceMimeTypeExtension on CourseResourceMimeType {
  String get displayLabel {
    switch (this) {
      case CourseResourceMimeType.DOCUMENT:
        return "Document";
      case CourseResourceMimeType.TEXT:
        return "Text";
      case CourseResourceMimeType.VIDEO:
        return "Video";
    }
  }

  Widget buildIcon() {
    switch (this) {
      case CourseResourceMimeType.DOCUMENT:
        return const HeroIcon(
          HeroIcons.chevronRight,
        );
      case CourseResourceMimeType.TEXT:
        return const HeroIcon(
          HeroIcons.chevronRight,
        );
      case CourseResourceMimeType.VIDEO:
        return const HeroIcon(
          HeroIcons.playCircle,
        );
    }
  }
}
