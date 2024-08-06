
import 'package:education_app/domain/model/user/user.dart';

sealed class SignUpEvent {}

final class OnSignUp extends SignUpEvent {
  final String email;
  final String password;
  final void Function(UserModel user) onSuccess;
  OnSignUp({
    required this.email,
    required this.password,
    required this.onSuccess,
  });
}

final class OnSignOut extends SignUpEvent {}

final class CheckLoggedIn extends SignUpEvent {}
