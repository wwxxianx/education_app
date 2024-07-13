import 'package:json_annotation/json_annotation.dart';

part 'tokens_response.g.dart';

@JsonSerializable()
class TokensResponse {
  final String accessToken;
  final String refreshToken;

  const TokensResponse({required this.accessToken, required this.refreshToken});

  factory TokensResponse.fromJson(Map<String, dynamic> json) =>
      _$TokensResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TokensResponseToJson(this);
}
