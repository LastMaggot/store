import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:store/comphonents/ResponseUtil.dart';
import 'package:store/constants/Constants.dart';
import 'package:store/pojo/app_pojo.dart';
import 'package:store/util/logs.dart';

class CustomerRequest {
  static Future<Response> signIn(String name, String password) async {
    Response response;
    response = await dio.get('$requestUrl/signIn',
        queryParameters: {"account": name, "password": password});
    return response;
  }
}
