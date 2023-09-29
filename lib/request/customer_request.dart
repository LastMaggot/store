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

  static Future<Response> signUp(String account, String password, String email) async {
    Response response;
    Customer customer = Customer(
      account: account,
      password: password,
      username: "用户$account",
      address: "null",
      email: email,
    );
    response = await dio.post('$requestUrl/signUp',data: customer.toJson());
    return response;
  }

  static Future<Response> forgetPassword(String account, String email) async {
    Response response;
    response = await dio.post('$requestUrl/forgetPassword',queryParameters: {"account":account,"email":email});
    return response;
  }
}
