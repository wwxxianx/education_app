
import 'package:education_app/domain/model/user.dart';

sealed class LoginEvent {}

final class OnLogin extends LoginEvent {
  final String email;
  final String password;
  // Update app user cubit and navigate to home or onboarding
  final void Function(UserModel user) onSuccess;
  OnLogin({
    required this.email,
    required this.password,
    required this.onSuccess,
  });
}