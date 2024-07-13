import 'package:education_app/common/error/failure.dart';
import 'package:education_app/common/usecase/usecase.dart';
import 'package:education_app/domain/model/user.dart';
import 'package:education_app/domain/repository/auth/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class LoginPayload {
  final String email;
  final String password;
  const LoginPayload({required this.email, required this.password});
}

class Login implements UseCase<UserModel, LoginPayload> {
  final AuthRepository authRepository;

  Login({required this.authRepository});

  @override
  Future<Either<Failure, UserModel>> call(LoginPayload payload) async {
    return await authRepository.loginWithEmailPassword(
        email: payload.email, password: payload.password);
  }
}
