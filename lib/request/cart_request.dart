import 'package:dio/dio.dart';
import 'package:store/constants/Constants.dart';
import 'package:store/pojo/app_pojo.dart';

class CartRequest {
  static Future<Response> getCartGoods(int user_id) async {
    Response response;
    response = await dio.get('$requestUrl/getCartGoods',queryParameters: {"user_id":user_id});
    return response;
  }

  static Future<Response> addToCart(int user_id, int goods_id, int num) async {
    Response response;
    response = await dio.post('$requestUrl/addToCart',queryParameters: {"user_id":user_id,"goods_id":goods_id,"num":num});
    return response;
  }

  static Future<Response> deleteFromCart(int id) async {
    Response response;
    response = await dio.delete('$requestUrl/deleteFromCart',queryParameters: {"id":id});
    return response;
  }

  static Future<Response> buy(int id, int goods_id, int num) async {
    Response response;
    response = await dio.put('$requestUrl/buy',queryParameters: {"cart_id":id,"goods_id":goods_id,"num":num});
    return response;
  }
}