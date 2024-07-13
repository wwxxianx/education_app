import 'package:json_annotation/json_annotation.dart';

part 'sign_up_payload.g.dart';

@JsonSerializable()
class SignUpPayload {
  final String id;
  final String email;
  final String fullName;

  SignUpPayload(
      {required this.id, required this.email, required this.fullName});

  Map<String, dynamic> toJson() => _$SignUpPayloadToJson(this);

  factory SignUpPayload.fromJson(Map<String, dynamic> json) =>
      _$SignUpPayloadFromJson(json);
}
