import 'package:json_annotation/json_annotation.dart';

part 'image_model.g.dart';

@JsonSerializable()
class ImageModel {
  final String id;
  final String imageUrl;

  const ImageModel({
    required this.id,
    required this.imageUrl,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) =>
      _$ImageModelFromJson(json);

  Map<String, dynamic> toJson() => _$ImageModelToJson(this);

  static const sample = ImageModel(
    id: 'sample-id',
    imageUrl:
        "https://yyavkrjmlxoqxeeybxuc.supabase.co/storage/v1/object/public/campaign/thumbnail/larm-rmah-AEaTUnvneik-unsplash.jpg",
  );

  static const samples = [
    ImageModel(
      id: 'sample-1',
      imageUrl:
          "https://yyavkrjmlxoqxeeybxuc.supabase.co/storage/v1/object/public/campaign/thumbnail/larm-rmah-AEaTUnvneik-unsplash.jpg",
    ),
    ImageModel(
      id: 'sample-2',
      imageUrl:
          "https://yyavkrjmlxoqxeeybxuc.supabase.co/storage/v1/object/public/campaign/thumbnail/larm-rmah-AEaTUnvneik-unsplash.jpg",
    ),
    ImageModel(
      id: 'sample-3',
      imageUrl:
          "https://yyavkrjmlxoqxeeybxuc.supabase.co/storage/v1/object/public/campaign/thumbnail/larm-rmah-AEaTUnvneik-unsplash.jpg",
    ),
  ];
}
