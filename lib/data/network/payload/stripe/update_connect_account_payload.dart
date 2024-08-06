import 'package:json_annotation/json_annotation.dart';

part 'update_connect_account_payload.g.dart';

@JsonSerializable()
class UpdateConnectAccountPayload {
  final String stripeConnectAccountId;

  const UpdateConnectAccountPayload({
    required this.stripeConnectAccountId,
  });

  factory UpdateConnectAccountPayload.fromJson(Map<String, dynamic> json) => _$UpdateConnectAccountPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateConnectAccountPayloadToJson(this);
}