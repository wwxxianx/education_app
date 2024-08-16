import 'package:education_app/domain/model/course_category/course_category.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class OnboardingEvent {
  const OnboardingEvent();
}

final class CompleteOnboarding extends OnboardingEvent {
  final VoidCallback onSuccess;

  const CompleteOnboarding({
    required this.onSuccess,
  });
}

final class OnSelectCourseCategory extends OnboardingEvent {
  final CourseCategory category;

  const OnSelectCourseCategory({
    required this.category
  });
}