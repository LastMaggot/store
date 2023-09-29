
import 'package:json_annotation/json_annotation.dart';
import 'package:store/pojo/goods.dart';
import 'package:store/pojo/customer.dart';

@JsonSerializable(explicitToJson: true)
class Order {
  int? id;
  int? user_id;
  int? goods_id;
  int? num;
  int? price;
  DateTime? create_time;

  Order({
    this.id,
    this.user_id,
    this.goods_id,
    this.num,
    this.price,
    this.create_time,
  });

  // 工厂方法，用于从Map转换为Order对象
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      user_id: json['user_id'],
      goods_id: json['goods_id'],
      num: json['num'],
      price: json['price'],
      create_time: DateTime.parse(json['create_time']) as DateTime?,
    );
  }

  // 将Order对象转换为Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': user_id,
      'goods_id': goods_id,
      'num': num,
      'price': price,
      'create_time': create_time != null
          ? create_time!.millisecondsSinceEpoch ~/ 1000
          : null,
    };
  }

  @override
  String toString() {
    return 'Order{id: $id, user_id: $user_id, goods_id: $goods_id, num: $num, price: $price, create_time: $create_time}';
  }
}
