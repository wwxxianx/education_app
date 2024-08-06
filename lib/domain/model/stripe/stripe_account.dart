import 'package:json_annotation/json_annotation.dart';

part 'stripe_account.g.dart';

@JsonSerializable()
class StripeAccount {
  final String id;
  @JsonKey(name: "details_submitted")
  final bool detailsSubmitted;
  final String? email;
  @JsonKey(name: "payouts_enabled")
  final bool payoutsEnabled;
  final StripeAccountRequirements? requirements;

  StripeAccount({
    required this.id,
    required this.detailsSubmitted,
    this.email,
    required this.payoutsEnabled,
    this.requirements,
  });

  factory StripeAccount.fromJson(Map<String, dynamic> json) =>
      _$StripeAccountFromJson(json);

  Map<String, dynamic> toJson() => _$StripeAccountToJson(this);
}

@JsonSerializable()
class StripeAccountRequirements {
  final List<StripeAccountError>? errors;

  StripeAccountRequirements({
    this.errors,
  });

  factory StripeAccountRequirements.fromJson(Map<String, dynamic> json) =>
      _$StripeAccountRequirementsFromJson(json);

  Map<String, dynamic> toJson() => _$StripeAccountRequirementsToJson(this);
}

@JsonSerializable()
class StripeAccountError {
  final String? code;
  final String? reason;
  final String? requirement;

  StripeAccountError({
    this.code,
    this.reason,
    this.requirement,
  });

  factory StripeAccountError.fromJson(Map<String, dynamic> json) =>
      _$StripeAccountErrorFromJson(json);

  Map<String, dynamic> toJson() => _$StripeAccountErrorToJson(this);
}
