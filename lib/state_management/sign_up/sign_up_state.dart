

import 'package:education_app/domain/model/user/user.dart';

sealed class SignUpState {
  const SignUpState();
}

final class SignUpInitial extends SignUpState {}

final class SignUpLoading extends SignUpState {}

final class SignUpSuccess extends SignUpState {
  // Get back from API
  // Save into SP for later use
  final UserModel? user;
  const SignUpSuccess(this.user);
}

final class SignUpFailure extends SignUpState {
  final String message;
  const SignUpFailure(this.message);
}
