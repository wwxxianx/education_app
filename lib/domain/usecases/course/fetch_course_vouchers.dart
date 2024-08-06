import 'package:education_app/common/error/failure.dart';
import 'package:education_app/common/usecase/usecase.dart';
import 'package:education_app/domain/model/voucher/voucher.dart';
import 'package:education_app/domain/repository/course/course_repository.dart';
import 'package:fpdart/src/either.dart';

class FetchCourseVouchers implements UseCase<List<CourseVoucher>, String> {
  final CourseRepository courseRepository;

  const FetchCourseVouchers({required this.courseRepository});
  @override
  Future<Either<Failure, List<CourseVoucher>>> call(String payload) async {
    return await courseRepository.getCourseVouchers(payload);
  }
}
