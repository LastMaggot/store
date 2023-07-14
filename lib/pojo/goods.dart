import 'package:json_annotation/json_annotation.dart';
part 'goods.g.dart';

@JsonSerializable(explicitToJson: true)
class Goods extends Object {
  int? id;
  String? name;
  String? manufacturer;
  String? pictureUrl;
  String? version;
  String? description;
  String? publishingHouse;
  int? purchaseCost;
  int? retailPrice;

  Goods(
      this.id,
      this.name,
      this.manufacturer,
      this.pictureUrl,
      this.version,
      this.description,
      this.publishingHouse,
      this.purchaseCost,
      this.retailPrice);

  factory Goods.fromJson(Map<String,dynamic> json) => _$GoodsFromJson(json);

  Map<String,dynamic> toJson() => _$GoodsToJson(this);

  @override
  String toString() {
    return 'Goods{id: $id, name: $name, manufacturer: $manufacturer, pictureUrl: $pictureUrl, version: $version, description: $description, publishingHouse: $publishingHouse, purchase_cost: $purchaseCost, retail_price: $retailPrice}';
  }
}
