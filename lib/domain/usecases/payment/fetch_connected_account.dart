import 'package:education_app/common/error/failure.dart';
import 'package:education_app/common/usecase/usecase.dart';
import 'package:education_app/data/service/payment/payment_service.dart';
import 'package:education_app/domain/model/stripe/stripe_account.dart';
import 'package:fpdart/src/either.dart';

class FetchConnectedAccount implements UseCase<StripeAccount?, NoPayload> {
  final PaymentService paymentService;

  const FetchConnectedAccount({required this.paymentService});

  @override
  Future<Either<Failure, StripeAccount?>> call(NoPayload payload) async {
    return await paymentService.getConnectedAccount();
  }
}
