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
