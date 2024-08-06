import 'package:flutter/material.dart';

@immutable
sealed class MyInstructorAccountEvent {
  const MyInstructorAccountEvent();
}

final class OnFetchInstructorProfile extends MyInstructorAccountEvent {
  final String userId;

  const OnFetchInstructorProfile({
    required this.userId,
  });
}
