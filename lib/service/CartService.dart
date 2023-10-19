import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:store/pojo/app_pojo.dart';
import 'package:store/util/data_processor.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../request/cart_request.dart';
import '../util/logs.dart';


class CartService {

  static Future<List<Goods>> getCartGoods(int user_id) async {
    Response response = await CartRequest.getCartGoods(user_id);
    DataProcessor<Goods> dataProcessor = DataProcessor<Goods>();
    List<Goods> goodsList = dataProcessor.listDataFromResponse(response,constructor: Goods.fromJson);
    for(Goods goods in goodsList) {
      Logger.log(msg: goods.toString());
    }
    return goodsList;
  }

  static Future<bool> addToCart(int user_id, int goods_id, int num) async {
    Response response = await CartRequest.addToCart(user_id, goods_id, num);
    Result result = Result.fromResponse(response);
    if(result.isValid()) {
      Fluttertoast.showToast(msg: "成功加入购物车");
      return true;
    }
    return false;
  }

  static Future<bool> deleteFromCart(int id) async {
    Response response = await CartRequest.deleteFromCart(id);
    Result result = Result.fromResponse(response);
    if(result.isValid()) {
      Fluttertoast.showToast(msg: "成功移出购物车");
      return true;
    }
    return false;
  }

  static Future<bool> buy(int id, int goods_id, int num) async {
    Response response = await CartRequest.buy(id, goods_id, num);
    Result result = Result.fromResponse(response);
    if(result.isValid()) {
      return true;
    }
    return false;
  }

}