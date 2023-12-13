// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dataproduct_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cosmetic _$CosmeticFromJson(Map<String, dynamic> json) => Cosmetic(
      id: json['id'] as int,
      name: json['name'] as String,
      priceTg: json['priceTg'] as int,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
    );

Map<String, dynamic> _$CosmeticToJson(Cosmetic instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'priceTg': instance.priceTg,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
    };
