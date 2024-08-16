import 'dart:io';

import 'package:education_app/data/network/payload/course/course_part_payload.dart';
import 'package:education_app/data/network/payload/course/course_payload.dart';
import 'package:education_app/data/network/payload/course/course_section_payload.dart';
import 'package:education_app/domain/model/course/course.dart';
import 'package:education_app/domain/model/course/enum/course_enum.dart';
import 'package:flutter/material.dart';

@immutable
sealed class ManageCourseDetailsEvent {
  const ManageCourseDetailsEvent();
}

final class OnFetchCourse extends ManageCourseDetailsEvent {
  final String courseId;

  const OnFetchCourse(this.courseId);
}

final class OnFetchCourseFAQ extends ManageCourseDetailsEvent {
  final String courseId;

  const OnFetchCourseFAQ(this.courseId);
}

final class OnTabIndexChanged extends ManageCourseDetailsEvent {
  final int index;

  const OnTabIndexChanged(this.index);
}

final class OnUpdateCourse extends ManageCourseDetailsEvent {
  final String courseId;
  final UpdateCoursePayload? payload;
  final VoidCallback? onSuccess;

  const OnUpdateCourse({
    this.payload,
    this.onSuccess,
    required this.courseId,
  });
}

final class OnUpdateCourseStatus extends ManageCourseDetailsEvent {
  final String courseId;
  final CoursePublishStatus status;
  final VoidCallback onSuccess;
  const OnUpdateCourseStatus({
    required this.courseId,
    required this.status,
    required this.onSuccess,
  });
}

final class OnAddFAQ extends ManageCourseDetailsEvent {}

final class OnFAQQuestionChanged extends ManageCourseDetailsEvent {
  final int index;
  final String value;

  const OnFAQQuestionChanged({required this.index, required this.value});
}

final class OnFAQAnswerChanged extends ManageCourseDetailsEvent {
  final int index;
  final String value;

  const OnFAQAnswerChanged({required this.index, required this.value});
}

final class OnUpdateCourseFAQ extends ManageCourseDetailsEvent {
  final String courseId;
  final VoidCallback onSuccess;

  const OnUpdateCourseFAQ({
    required this.courseId,
    required this.onSuccess,
  });
}

final class OnFetchCourseVouchers extends ManageCourseDetailsEvent {
  final String courseId;

  const OnFetchCourseVouchers(this.courseId);
}

final class OnCreateCourseVoucher extends ManageCourseDetailsEvent {
  final String courseId;
  final VoidCallback onSuccess;

  const OnCreateCourseVoucher(
      {required this.courseId, required this.onSuccess});
}

final class OnDiscountChanged extends ManageCourseDetailsEvent {
  final String value;

  const OnDiscountChanged({required this.value});
}

final class OnVoucherTitleChanged extends ManageCourseDetailsEvent {
  final String value;

  const OnVoucherTitleChanged({required this.value});
}

final class OnVoucherExpirationDateChanged extends ManageCourseDetailsEvent {
  final DateTime value;

  const OnVoucherExpirationDateChanged({required this.value});
}

final class OnVoucherStockChanged extends ManageCourseDetailsEvent {
  final String value;

  const OnVoucherStockChanged({required this.value});
}

final class OnSelectCourseCategory extends ManageCourseDetailsEvent {
  final String categoryId;

  const OnSelectCourseCategory({required this.categoryId});
}

final class OnSelectCourseSubcategory extends ManageCourseDetailsEvent {
  final String categoryId;

  const OnSelectCourseSubcategory({required this.categoryId});
}

final class OnSelectLevel extends ManageCourseDetailsEvent {
  final String levelId;

  const OnSelectLevel({required this.levelId});
}

final class OnTitleChanged extends ManageCourseDetailsEvent {
  final String value;

  const OnTitleChanged({required this.value});
}

final class OnPriceChanged extends ManageCourseDetailsEvent {
  final String value;

  const OnPriceChanged({required this.value});
}

final class OnUpdateCourseSection extends ManageCourseDetailsEvent {
  final UpdateCourseSectionPayload payload;
  final void Function(CourseSection data) onSuccess;

  const OnUpdateCourseSection({required this.payload, required this.onSuccess});
}

final class OnCreateCoursePart extends ManageCourseDetailsEvent {
  final CreateCoursePartPayload payload;
  final void Function(CoursePart data) onSuccess;

  const OnCreateCoursePart({required this.payload, required this.onSuccess});
}

final class OnCreateCourseSection extends ManageCourseDetailsEvent {
  final String courseId;
  final void Function(CourseSection data) onSuccess;

  const OnCreateCourseSection({required this.courseId, required this.onSuccess});
}

final class OnAddNewPart extends ManageCourseDetailsEvent {}

final class OnRemovePart extends ManageCourseDetailsEvent {
  final int index;

  const OnRemovePart({required this.index});
}

final class OnPartTitleChanged extends ManageCourseDetailsEvent {
  final int index;
  final String title;

  const OnPartTitleChanged({required this.index, required this.title});
}

final class OnPartFileChanged extends ManageCourseDetailsEvent {
  final int index;
  final File? file;

  const OnPartFileChanged({required this.index, required this.file});
}

final class OnSectionTitleChanged extends ManageCourseDetailsEvent {
  final String value;

  const OnSectionTitleChanged({required this.value});
}