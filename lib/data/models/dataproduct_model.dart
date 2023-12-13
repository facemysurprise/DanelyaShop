import 'package:json_annotation/json_annotation.dart';

part 'dataproduct_model.g.dart'; 

@JsonSerializable()
class Cosmetic {
  final int id;
  final String name;
  final int priceTg;
  final String description;
  final String imageUrl;

  Cosmetic({
    required this.id,
    required this.name,
    required this.priceTg,
    required this.description,
    required this.imageUrl,
  });

  factory Cosmetic.fromJson(Map<String, dynamic> json) {
    return Cosmetic(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      priceTg: json['price_tg'] as int? ?? 0,
      description: json['description'] as String? ?? '',
      imageUrl: json['image_url'] as String? ?? '',
    );
  }
  
  Map<String, dynamic> toJson() => _$CosmeticToJson(this);
}