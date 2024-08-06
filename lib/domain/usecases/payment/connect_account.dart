import 'package:education_app/common/error/failure.dart';
import 'package:education_app/common/usecase/usecase.dart';
import 'package:education_app/data/service/payment/payment_service.dart';
import 'package:education_app/domain/model/stripe/connect_account_response.dart';
import 'package:fpdart/src/either.dart';

class ConnectAccount implements UseCase<ConnectAccountResponse, NoPayload> {
  final PaymentService paymentService;

  const ConnectAccount({required this.paymentService});

  @override
  Future<Either<Failure, ConnectAccountResponse>> call(
      NoPayload payload) async {
    return await paymentService.connectAccount();
  }
}
