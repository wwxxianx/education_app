import 'package:flutter/material.dart';

@immutable
sealed class ManageCourseDetailsEvent {
  const ManageCourseDetailsEvent();
}

final class OnFetchCourse extends ManageCourseDetailsEvent {
  final String courseId;

  const OnFetchCourse(this.courseId);
}

final class OnTabIndexChanged extends ManageCourseDetailsEvent {
  final int index;

  const OnTabIndexChanged(this.index);
}
