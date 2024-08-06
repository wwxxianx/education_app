import 'package:education_app/common/error/failure.dart';
import 'package:education_app/common/usecase/usecase.dart';
import 'package:education_app/data/network/payload/voucher/voucher_payload.dart';
import 'package:education_app/domain/model/voucher/voucher.dart';
import 'package:education_app/domain/repository/course/course_repository.dart';
import 'package:fpdart/fpdart.dart';

class CreateCourseVoucher implements UseCase<CourseVoucher, CreateVoucherPayload> {
  final CourseRepository courseRepository;

  const CreateCourseVoucher({required this.courseRepository});

  @override
  Future<Either<Failure, CourseVoucher>> call(CreateVoucherPayload payload) async {
    return await courseRepository.createCourseVoucher(payload);
  }
}