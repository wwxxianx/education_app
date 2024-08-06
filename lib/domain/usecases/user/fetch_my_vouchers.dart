import 'package:education_app/common/error/failure.dart';
import 'package:education_app/common/usecase/usecase.dart';
import 'package:education_app/domain/model/voucher/user_voucher.dart';
import 'package:education_app/domain/repository/user/user_repository.dart';
import 'package:fpdart/src/either.dart';

class FetchMyVouchers implements UseCase<List<UserVoucher>, NoPayload> {
  final UserRepository userRepository;

  const FetchMyVouchers({required this.userRepository});

  @override
  Future<Either<Failure, List<UserVoucher>>> call(NoPayload payload) async {
    return await userRepository.getMyVouchers();
  }
}
