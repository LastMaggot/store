import 'package:dio/dio.dart';
import 'package:store/pojo/app_pojo.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DataProcessor<T> {

  List<T> listDataFromResponse(Response response, {T Function(Map<String,dynamic>)? constructor}) {
    Map<String,dynamic> data = response.data;
    if(constructor == null) {
      Fluttertoast.showToast(msg: "invalid constructor");
      return [];
    }
    int code = data['code'] as int;
    if(code == 0) {
      String errorTips = data['msg'] as String;
      Fluttertoast.showToast(msg: errorTips);
      return [];
    }
    List<T> res = [];
    List<dynamic> dataList = data['data'];
    for(Map<String,dynamic> json in dataList) {
      res.add(constructor(json));
    }
    return res;
  }
}