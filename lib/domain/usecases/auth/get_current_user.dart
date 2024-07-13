import 'package:education_app/common/error/failure.dart';
import 'package:education_app/common/usecase/usecase.dart';
import 'package:education_app/domain/model/user.dart';
import 'package:education_app/domain/repository/user/user_repository.dart';
import 'package:fpdart/src/either.dart';

class GetCurrentUser implements UseCase<UserModel, NoPayload> {
  final UserRepository userRepository;
  GetCurrentUser(this.userRepository);

  @override
  Future<Either<Failure, UserModel>> call(NoPayload payload) async {
    return await userRepository.getUserProfile();
  }
}
