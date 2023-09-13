import 'package:dio/dio.dart';
import 'package:store/comphonents/ResponseUtil.dart';
import 'package:store/constants/Constants.dart';
import 'package:store/pojo/app_pojo.dart';
import 'package:store/util/logs.dart';

class GoodsRequest {
  static Future<Response> getAllGoods() async {
    try{
      Response response;
      response = await dio.get("$requestUrl/getAllGoods");
      return response;
    } catch (e) {
      Logger.error(msg: e.toString());
      return ResponseUtil.connectionError();
    }
  }
  
  static Future<Response> getGoodsByName(String name) async {
    try {
      Response response;
      response = await dio.get("$requestUrl/getGoodsByName",queryParameters: {'name':name});
      return response;
    } catch (e) {
      Logger.error(msg: e.toString());
      return ResponseUtil.connectionError();
    }
  }

}