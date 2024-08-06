import 'package:flutter/material.dart';

@immutable
sealed class MyLearningEvent {
  const MyLearningEvent();
}

final class OnFetchMyLearningCourses extends MyLearningEvent {}
