import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:store/comphonents/ResponseUtil.dart';
import 'package:store/constants/Constants.dart';
import 'package:store/pojo/app_pojo.dart';
import 'package:store/util/logs.dart';


class OrderRequest {
  static Future<Response> getOrders(int user_id) async {
    Response response;
    response = await dio.get("$requestUrl/getOrders",queryParameters: {"user_id":user_id});
    return response;
  }

  static Future<Response> createOrder(Order order) async {
    Response response;
    response = await dio.post("$requestUrl/createOrder",data: order.toJson());
    return response;
  }
}