import 'package:education_app/common/error/failure.dart';
import 'package:education_app/common/usecase/usecase.dart';
import 'package:education_app/domain/model/user.dart';
import 'package:education_app/domain/repository/auth/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class SignUp implements UseCase<UserModel, AuthPayload> {
  final AuthRepository authRepository;

  SignUp(this.authRepository);

  @override
  Future<Either<Failure, UserModel>> call(AuthPayload payload) async {
    return await authRepository.createUserWithEmailPassword(
      email: payload.email,
      password: payload.password,
    );
  }
}

class AuthPayload {
  final String email;
  final String password;

  const AuthPayload({
    required this.email,
    required this.password,
  });
}
