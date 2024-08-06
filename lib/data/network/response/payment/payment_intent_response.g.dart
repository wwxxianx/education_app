// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_intent_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentIntentResponse _$PaymentIntentResponseFromJson(
        Map<String, dynamic> json) =>
    PaymentIntentResponse(
      clientSecret: json['clientSecret'] as String,
      ephemeralKey: json['ephemeralKey'] as String,
      customer: json['customer'] as String?,
      publishableKey: json['publishableKey'] as String,
      stripeAccountId: json['stripeAccountId'] as String?,
    );

Map<String, dynamic> _$PaymentIntentResponseToJson(
        PaymentIntentResponse instance) =>
    <String, dynamic>{
      'clientSecret': instance.clientSecret,
      'ephemeralKey': instance.ephemeralKey,
      'customer': instance.customer,
      'publishableKey': instance.publishableKey,
      'stripeAccountId': instance.stripeAccountId,
    };
