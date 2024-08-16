import 'package:education_app/domain/model/user/user.dart';
import 'package:flutter/material.dart';

@immutable
sealed class AccountPreferencesEvent {
  const AccountPreferencesEvent();
}

final class OnSelectCategory extends AccountPreferencesEvent {
  final String id;

  const OnSelectCategory({required this.id});
}

final class OnUpdateUser extends AccountPreferencesEvent {
  final void Function(UserModel user) onSuccess;

  const OnUpdateUser({required this.onSuccess});
}

final class OnInitSelectedCategoryIds extends AccountPreferencesEvent {
  final UserModel? currentUser;

  const OnInitSelectedCategoryIds({required this.currentUser});
}
