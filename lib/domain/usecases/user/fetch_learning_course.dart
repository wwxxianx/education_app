import 'package:education_app/common/error/failure.dart';
import 'package:education_app/common/usecase/usecase.dart';
import 'package:education_app/data/network/payload/user/learning_courses_filter.dart';
import 'package:education_app/domain/model/user/user_course.dart';
import 'package:education_app/domain/repository/user/user_repository.dart';
import 'package:fpdart/fpdart.dart';

class FetchLearningCourse implements UseCase<UserCourse?, String> {
  final UserRepository userRepository;

  const FetchLearningCourse({required this.userRepository});

  @override
  Future<Either<Failure, UserCourse?>> call(String courseId) async {
    final filter = LearningCoursesFilter(courseId: courseId);
    return await userRepository.getUserLearningCourse(filter);
  }
}
