import 'package:education_app/common/error/failure.dart';
import 'package:education_app/common/usecase/usecase.dart';
import 'package:education_app/data/network/payload/voucher/claim_voucher_payload.dart';
import 'package:education_app/domain/model/voucher/user_voucher.dart';
import 'package:education_app/domain/repository/course/course_repository.dart';
import 'package:fpdart/src/either.dart';

class ClaimVoucher implements UseCase<UserVoucher, ClaimVoucherPayload> {
  final CourseRepository courseRepository;

  const ClaimVoucher({required this.courseRepository});

  @override
  Future<Either<Failure, UserVoucher>> call(ClaimVoucherPayload payload) async {
    return await courseRepository.claimVoucher(payload);
  }
}
