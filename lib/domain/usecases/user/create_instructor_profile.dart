import 'package:education_app/common/error/failure.dart';
import 'package:education_app/common/usecase/usecase.dart';
import 'package:education_app/data/network/payload/user/instructor_profile_payload.dart';
import 'package:education_app/domain/model/user/instructor_profile.dart';
import 'package:education_app/domain/repository/user/user_repository.dart';
import 'package:fpdart/src/either.dart';

class CreateInstructorProfile
    implements UseCase<InstructorProfile, CreateInstructorProfilePayload> {
  final UserRepository userRepository;

  const CreateInstructorProfile({required this.userRepository});

  @override
  Future<Either<Failure, InstructorProfile>> call(
      CreateInstructorProfilePayload payload) async {
    return await userRepository.createInstructorProfile(payload);
  }
}
