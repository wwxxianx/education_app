import 'package:education_app/common/error/failure.dart';
import 'package:education_app/common/usecase/usecase.dart';
import 'package:education_app/data/network/payload/user/user_profile_payload.dart';
import 'package:education_app/domain/model/user.dart';
import 'package:education_app/domain/repository/user/user_repository.dart';
import 'package:fpdart/src/either.dart';

class UpdateUserProfile implements UseCase<UserModel, UserProfilePayload> {
  final UserRepository userRepository;

  UpdateUserProfile({required this.userRepository});

  @override
  Future<Either<Failure, UserModel>> call(UserProfilePayload payload) async {
    return await userRepository.updateUserProfile(payload);
  }
}
