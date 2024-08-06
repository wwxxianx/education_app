// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stripe_account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StripeAccount _$StripeAccountFromJson(Map<String, dynamic> json) =>
    StripeAccount(
      id: json['id'] as String,
      detailsSubmitted: json['details_submitted'] as bool,
      email: json['email'] as String?,
      payoutsEnabled: json['payouts_enabled'] as bool,
      requirements: json['requirements'] == null
          ? null
          : StripeAccountRequirements.fromJson(
              json['requirements'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StripeAccountToJson(StripeAccount instance) =>
    <String, dynamic>{
      'id': instance.id,
      'details_submitted': instance.detailsSubmitted,
      'email': instance.email,
      'payouts_enabled': instance.payoutsEnabled,
      'requirements': instance.requirements,
    };

StripeAccountRequirements _$StripeAccountRequirementsFromJson(
        Map<String, dynamic> json) =>
    StripeAccountRequirements(
      errors: (json['errors'] as List<dynamic>?)
          ?.map((e) => StripeAccountError.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StripeAccountRequirementsToJson(
        StripeAccountRequirements instance) =>
    <String, dynamic>{
      'errors': instance.errors,
    };

StripeAccountError _$StripeAccountErrorFromJson(Map<String, dynamic> json) =>
    StripeAccountError(
      code: json['code'] as String?,
      reason: json['reason'] as String?,
      requirement: json['requirement'] as String?,
    );

Map<String, dynamic> _$StripeAccountErrorToJson(StripeAccountError instance) =>
    <String, dynamic>{
      'code': instance.code,
      'reason': instance.reason,
      'requirement': instance.requirement,
    };
