
import 'package:education_app/domain/model/user.dart';

sealed class LoginState {
  const LoginState();
}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  // Get back from API
  // Save into SP for later use
  final UserModel? user;
  const LoginSuccess(this.user);
}

final class LoginFailure extends LoginState {
  final String message;
  const LoginFailure(this.message);
}
