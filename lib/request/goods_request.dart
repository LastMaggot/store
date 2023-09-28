import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:store/comphonents/ResponseUtil.dart';
import 'package:store/constants/Constants.dart';
import 'package:store/pojo/app_pojo.dart';
import 'package:store/util/logs.dart';

class GoodsRequest {
  static Future<Response> getAllGoods() async {
    Response response;
    response = await dio.get("$requestUrl/getAllGoods");
    return response;
  }

  static Future<Response> getGoodsByName(String name) async {
    Logger.log(msg: "搜索$name");
    Response response;
    response = await dio
        .get("$requestUrl/getByName", queryParameters: {'name': "$name"});
    return response;
  }
}
