import 'package:json_annotation/json_annotation.dart';

part 'connect_account_response.g.dart';

@JsonSerializable()
class ConnectAccountResponse {
  final String onboardLink;

  const ConnectAccountResponse({
    required this.onboardLink,
  });

  factory ConnectAccountResponse.fromJson(Map<String, dynamic> json) => _$ConnectAccountResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ConnectAccountResponseToJson(this);
}