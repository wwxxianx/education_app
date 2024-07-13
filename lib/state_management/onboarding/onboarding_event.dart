import 'package:education_app/data/network/payload/user/user_profile_payload.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class OnboardingEvent {
  const OnboardingEvent();
}

final class CompleteOnboarding extends OnboardingEvent {
  final UserProfilePayload payload;
  final VoidCallback onSuccess;

  const CompleteOnboarding({
    required this.payload,
    required this.onSuccess,
  });
}
