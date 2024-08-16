import 'package:education_app/common/error/failure.dart';
import 'package:education_app/common/usecase/usecase.dart';
import 'package:education_app/domain/model/user/course_progress.dart';
import 'package:education_app/domain/repository/user/user_repository.dart';
import 'package:fpdart/src/either.dart';

class FetchRecentCourseProgress implements UseCase<CourseProgress, NoPayload> {
  final UserRepository userRepository;

  const FetchRecentCourseProgress({required this.userRepository});

  @override
  Future<Either<Failure, CourseProgress>> call(NoPayload payload) async {
    return await userRepository.getRecentCourseProgress();
  }
}
