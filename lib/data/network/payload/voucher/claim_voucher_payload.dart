import 'package:json_annotation/json_annotation.dart';

part 'claim_voucher_payload.g.dart';

@JsonSerializable()
class ClaimVoucherPayload {
  final String voucherId;

  const ClaimVoucherPayload({
    required this.voucherId,
  });

  factory ClaimVoucherPayload.fromJson(Map<String, dynamic> json) => _$ClaimVoucherPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$ClaimVoucherPayloadToJson(this);
}