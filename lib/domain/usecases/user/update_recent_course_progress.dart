import 'package:education_app/common/error/failure.dart';
import 'package:education_app/common/usecase/usecase.dart';
import 'package:education_app/data/network/payload/user/course_progress_payload.dart';
import 'package:education_app/domain/model/user/course_progress.dart';
import 'package:education_app/domain/repository/user/user_repository.dart';
import 'package:fpdart/src/either.dart';

class UpdateRecentCourseProgress
    implements UseCase<CourseProgress, CourseProgressPayload> {
  final UserRepository userRepository;

  const UpdateRecentCourseProgress({required this.userRepository});

  @override
  Future<Either<Failure, CourseProgress>> call(
      CourseProgressPayload payload) async {
    return await userRepository.updateCourseProgress(payload);
  }
}
