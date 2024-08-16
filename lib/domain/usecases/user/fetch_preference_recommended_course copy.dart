import 'package:education_app/common/error/failure.dart';
import 'package:education_app/common/usecase/usecase.dart';
import 'package:education_app/domain/model/course/course.dart';
import 'package:education_app/domain/repository/user/user_repository.dart';
import 'package:fpdart/src/either.dart';

class FetchPreferenceRecommendedCourse
    implements UseCase<List<Course>, NoPayload> {
  final UserRepository userRepository;

  const FetchPreferenceRecommendedCourse({required this.userRepository});

  @override
  Future<Either<Failure, List<Course>>> call(NoPayload payload) async {
    return await userRepository.findRecommendedCourseFromPreference();
  }
}
