import 'package:education_app/data/network/payload/user/user_profile_payload.dart';
import 'package:education_app/domain/model/user/user.dart';
import 'package:flutter/material.dart';

@immutable
sealed class UserProfileEvent {
  const UserProfileEvent();
}

final class OnUpdateUserProfile extends UserProfileEvent {
  final UserProfilePayload payload;
  final void Function(UserModel user)? onSuccess;

  const OnUpdateUserProfile({
    required this.payload,
    this.onSuccess,
  });
}
