import 'package:education_app/data/network/payload/voucher/claim_voucher_payload.dart';
import 'package:education_app/domain/model/voucher/user_voucher.dart';
import 'package:flutter/material.dart';

@immutable
sealed class CourseDetailsEvent {
  const CourseDetailsEvent();
}

final class OnFetchCourse extends CourseDetailsEvent {
  final String courseId;

  const OnFetchCourse(this.courseId);
}

final class OnTabIndexChanged extends CourseDetailsEvent {
  final int index;

  const OnTabIndexChanged(this.index);
}

final class OnFetchUserCourse extends CourseDetailsEvent {
  final String courseId;

  const OnFetchUserCourse(this.courseId);
}

final class OnFetchCourseFAQ extends CourseDetailsEvent {
  final String courseId;

  const OnFetchCourseFAQ(this.courseId);
}

final class OnFetchCourseVoucher extends CourseDetailsEvent {
  final String courseId;

  const OnFetchCourseVoucher(this.courseId);
}

final class OnClaimVoucher extends CourseDetailsEvent {
  final ClaimVoucherPayload payload;
  final void Function(UserVoucher voucher)? onSuccess;

  const OnClaimVoucher({required this.payload, this.onSuccess,});
}
