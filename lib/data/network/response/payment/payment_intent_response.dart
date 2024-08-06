import 'package:json_annotation/json_annotation.dart';

part 'payment_intent_response.g.dart';

@JsonSerializable()
class PaymentIntentResponse {
  final String clientSecret;
  final String ephemeralKey;
  final String? customer;
  final String publishableKey;
  final String? stripeAccountId;

  const PaymentIntentResponse({
    required this.clientSecret,
    required this.ephemeralKey,
    this.customer,
    required this.publishableKey,
    this.stripeAccountId,
  });

  factory PaymentIntentResponse.fromJson(Map<String, dynamic> json) =>
      _$PaymentIntentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentIntentResponseToJson(this);
}
