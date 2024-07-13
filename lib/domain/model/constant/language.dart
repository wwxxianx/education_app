import 'package:json_annotation/json_annotation.dart';

part 'language.g.dart';

@JsonSerializable()
class Language {
  final String id;
  final String language;

  const Language({
    required this.id,
    required this.language,
  });

  factory Language.fromJson(Map<String, dynamic> json) =>
      _$LanguageFromJson(json);

  Map<String, dynamic> toJson() => _$LanguageToJson(this);

  static const samples = [
    Language(
      id: '1',
      language: 'english',
    ),
    Language(
      id: '2',
      language: 'chinese',
    ),
  ];
}
