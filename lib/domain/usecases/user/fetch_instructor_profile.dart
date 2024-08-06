import 'package:education_app/common/error/failure.dart';
import 'package:education_app/common/usecase/usecase.dart';
import 'package:education_app/domain/model/user/instructor_profile.dart';
import 'package:education_app/domain/repository/user/user_repository.dart';
import 'package:fpdart/src/either.dart';

class FetchInstructorProfile implements UseCase<InstructorProfile?, String> {
  final UserRepository userRepository;

  const FetchInstructorProfile({required this.userRepository});
  @override
  Future<Either<Failure, InstructorProfile?>> call(String payload) async {
    return await userRepository.getInstructorProfile(userId: payload);
  }
}
