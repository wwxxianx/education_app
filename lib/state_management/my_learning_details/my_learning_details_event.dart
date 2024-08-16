import 'package:education_app/domain/model/course/course.dart';
import 'package:education_app/domain/model/user/course_progress.dart';
import 'package:flutter/material.dart';

@immutable
sealed class MyLearningDetailsEvent {
  const MyLearningDetailsEvent();
}

final class OnFetchCourse extends MyLearningDetailsEvent {
  final String courseId;
  final CoursePart? progressCoursePart;

  const OnFetchCourse({required this.courseId, this.progressCoursePart});
}

final class OnCurrentPartChanged extends MyLearningDetailsEvent {
  final CoursePart part;
  final String courseId;
  final void Function(CourseProgress data) onSuccess;

  const OnCurrentPartChanged({
    required this.part,
    required this.courseId,
    required this.onSuccess,
  });
}

final class OnInitFocusCoursePartFromProgress extends MyLearningDetailsEvent {
  final CoursePart? coursePart;

  const OnInitFocusCoursePartFromProgress({required this.coursePart});
}