
import 'package:json_annotation/json_annotation.dart';
import 'package:store/pojo/goods.dart';
import 'package:store/pojo/user.dart';

part 'order.g.dart';

@JsonSerializable(explicitToJson: true)
class Order extends Object {
  Customer? customer;
  Goods? goods;

  Order(this.customer, this.goods);

  factory Order.fromJson(Map<String,dynamic> json) => _$OrderFromJson(json);

  Map<String,dynamic> toJson() => _$OrderToJson(this);

  @override
  String toString() {
    return 'Order{customer: ${customer?.toString()}, goods: ${goods?.toString()}}';
  }
}