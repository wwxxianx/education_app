import 'package:education_app/common/error/failure.dart';
import 'package:education_app/common/usecase/usecase.dart';
import 'package:education_app/domain/model/user/user_course.dart';
import 'package:education_app/domain/repository/user/user_repository.dart';
import 'package:fpdart/src/either.dart';

class FetchLearningCourses implements UseCase<List<UserCourse>?, NoPayload> {
  final UserRepository userRepository;

  const FetchLearningCourses({required this.userRepository});

  @override
  Future<Either<Failure, List<UserCourse>?>> call(NoPayload payload) async {
    return await userRepository.getUserLearningCourses();
  }
}
