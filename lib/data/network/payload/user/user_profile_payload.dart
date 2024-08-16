import 'dart:io';

class UserProfilePayload {
  final File? profileImageFile;
  final String? fullName;
  final bool? isOnBoardingCompleted;
  final String? phoneNumber;
  final String? onesignalId;
  final List<String>? favouriteCourseCategoryIds;

  UserProfilePayload({
    this.profileImageFile,
    this.fullName,
    // This will only be called after the user completed onboarding
    // So, default to true
    this.isOnBoardingCompleted = true,
    this.phoneNumber,
    this.onesignalId,
    this.favouriteCourseCategoryIds = const [],
  });
}
