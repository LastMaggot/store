import 'package:dio/dio.dart';
import 'package:store/comphonents/ResponseUtil.dart';
import 'package:store/pojo/app_pojo.dart';
import 'package:store/request/Order_request.dart';
import 'package:store/util/data_processor.dart';
import 'package:store/util/logs.dart';
import 'package:fluttertoast/fluttertoast.dart';


class OrderService {
  static Future<List<Order>> getOrders(int user_id) async {
    Response response = await OrderRequest.getOrders(user_id);
    DataProcessor<Order> dataProcessor = DataProcessor<Order>();
    List<Order> OrderList = dataProcessor.listDataFromResponse(response,constructor: Order.fromJson);
    for(Order order in OrderList) {
      Logger.log(msg: order.toString());
    }
    return OrderList;
  }

  static Future<bool> createOrder(int user_id, int goods_id, int num,int price) async {
    Order order = Order(
      user_id: user_id,
      goods_id: goods_id,
      num: num,
      price: price,
    );
    Response response = await OrderRequest.createOrder(order);
    Result result = Result.fromResponse(response);
    if(result.isValid()) {
      Fluttertoast.showToast(msg: "成功加入购物车");
      return true;
    }
    return false;
  }
}