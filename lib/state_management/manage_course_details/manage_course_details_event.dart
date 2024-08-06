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

  const OnCreateCourseVoucher({required this.courseId, required this.onSuccess});
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
