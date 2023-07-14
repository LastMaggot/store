// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goods.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Goods _$GoodsFromJson(Map<String, dynamic> json) => Goods(
      json['id'] as int?,
      json['name'] as String?,
      json['manufacturer'] as String?,
      json['pictureUrl'] as String?,
      json['version'] as String?,
      json['description'] as String?,
      json['publishingHouse'] as String?,
      json['purchaseCost'] as int?,
      json['retailPrice'] as int?,
    );

Map<String, dynamic> _$GoodsToJson(Goods instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'manufacturer': instance.manufacturer,
      'pictureUrl': instance.pictureUrl,
      'version': instance.version,
      'description': instance.description,
      'publishingHouse': instance.publishingHouse,
      'purchaseCost': instance.purchaseCost,
      'retailPrice': instance.retailPrice,
    };
