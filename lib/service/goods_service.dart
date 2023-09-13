import 'package:dio/dio.dart';
import 'package:store/comphonents/ResponseUtil.dart';
import 'package:store/pojo/app_pojo.dart';
import 'package:store/request/goods_request.dart';
import 'package:store/util/data_processor.dart';
import 'package:store/util/logs.dart';

class GoodsService {

  static Future<List<Goods>> getGoodsByName(String name) async {
    Response response = await GoodsRequest.getGoodsByName(name);
    if(!ResponseUtil.responseIsValid(response)) {
      return [];
    }
    DataProcessor<Goods> dataProcessor = DataProcessor<Goods>();
    List<Goods> goodsList = dataProcessor.listDataFromResponse(response,constructor: Goods.fromJson);
    for(Goods goods in goodsList) {
      Logger.log(msg: goods.toString());
    }
    return goodsList;
  }

  static Future<List<Goods>> getAllGoods() async {
    Response response = await GoodsRequest.getAllGoods();
    if(!ResponseUtil.responseIsValid(response)) {
      return [];
    }
    DataProcessor<Goods> dataProcessor = DataProcessor<Goods>();
    List<Goods> goodsList = dataProcessor.listDataFromResponse(response,constructor: Goods.fromJson);
    for(Goods goods in goodsList) {
      Logger.log(msg: goods.toString());
    }
    return goodsList;
  }
}