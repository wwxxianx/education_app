import 'package:json_annotation/json_annotation.dart';

part 'login_be_payload.g.dart';

@JsonSerializable()
class LoginBEPayload {
  final String userId;

  const LoginBEPayload({
    required this.userId,
  });

  factory LoginBEPayload.fromJson(Map<String, dynamic> json) =>
      _$LoginBEPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$LoginBEPayloadToJson(this);
}
