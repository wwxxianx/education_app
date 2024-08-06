import 'package:education_app/domain/model/course/course.dart';
import 'package:flutter/material.dart';

@immutable
sealed class MyLearningDetailsEvent {
  const MyLearningDetailsEvent();
}

final class OnFetchCourse extends MyLearningDetailsEvent {
  final String courseId;

  const OnFetchCourse({required this.courseId});
}

final class OnCurrentPartChanged extends MyLearningDetailsEvent {
  final CoursePart part;

  const OnCurrentPartChanged({required this.part});
}
