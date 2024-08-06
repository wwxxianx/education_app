import 'package:education_app/common/error/failure.dart';
import 'package:education_app/data/network/payload/payment/course_payment_intent_payload.dart';
import 'package:education_app/data/network/response/payment/payment_intent_response.dart';
import 'package:education_app/data/network/retrofit_api.dart';
import 'package:education_app/domain/model/stripe/connect_account_response.dart';
import 'package:education_app/domain/model/stripe/stripe_account.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fpdart/fpdart.dart';
import 'package:logger/logger.dart';

class PaymentService {
  final logger = Logger();
  final RestClient api;

  PaymentService({required this.api});

  Future<Either<Failure, ConnectAccountResponse>> getUpdateConnectAccountLink() async {
    try {
      final res = await api.updateConnectAccount();
      return right(res);
    } catch (e) {
      return left(Failure('Failed to get connected account link'));
    }
  }

  Future<Either<Failure, StripeAccount?>> getConnectedAccount() async {
    try {
      final res =
          await api.getConnectedAccount();
      return right(res);
    } catch (e) {
      return left(Failure('Failed to get connected account details'));
    }
  }

  Future<Either<Failure, ConnectAccountResponse>> connectAccount() async {
    try {
      final res = await api.connectStripeAccount();
      return right(res);
    } catch (e) {
      return left(Failure('Failed to connect account'));
    }
  }

  Future<Either<Failure, Unit>> initCampaignDonationPaymentSheet(
    CoursePaymentIntentPayload coursePaymentIntentPayload,
  ) async {
    try {
      // 1. create payment intent on the server
      final PaymentIntentResponse paymentIntentRes = await api
          .createCoursePaymentIntent(coursePaymentIntentPayload);
      // Set to campaign launcher's stripe account id to receive donation
      Stripe.stripeAccountId = paymentIntentRes.stripeAccountId;
      // 2. initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          // Set to true for custom flow
          customFlow: false,
          // Main params
          merchantDisplayName: 'Flutter Stripe Store Demo',
          paymentIntentClientSecret: paymentIntentRes.clientSecret,
          // Customer keys
          customerEphemeralKeySecret: paymentIntentRes.ephemeralKey,
          customerId: paymentIntentRes.customer,
          style: ThemeMode.light,
          billingDetailsCollectionConfiguration:
              const BillingDetailsCollectionConfiguration(
            address: AddressCollectionMode.never,
          ),
        ),
      );
      return right(unit);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, Unit>> presentPaymentSheet() async {
    await Stripe.instance.presentPaymentSheet();
    return right(unit);
    // try {
    //   await Stripe.instance.presentPaymentSheet();
    //   return right(unit);
    // } catch (e) {
    //   logger.w("Error: $e");
    //   return left(Failure("Failed to pay..."));
    // }
  }
}
