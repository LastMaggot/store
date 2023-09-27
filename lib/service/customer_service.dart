import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store/comphonents/ResponseUtil.dart';
import 'package:store/global/app_globals.dart';
import 'package:store/pojo/app_pojo.dart';
import 'package:dio/dio.dart';
import 'package:store/reference/references.dart';
import 'package:store/request/customer_request.dart';

class CustomerService {

  static Future<Customer?> signIn(String account,String password,{required BuildContext context}) async {
    Response response = await CustomerRequest.signIn(account, password);
    if(!ResponseUtil.responseIsValid(response)) {
      return null;
    }
    Result<Customer> result = Result.fromResponse(response,constructor: Customer.fromJson);
    if(result.isValid()) {
      AppGlobals appGlobals = context.read<AppGlobals>();
      appGlobals.token = result.msg;
      appGlobals.customer = result.data;
      SharedPreferences _cache = appGlobals.cache;
      _cache.setString('token', result.msg);
      return result.data;
    }
    return null;
  }

  static bool hasLogin({required BuildContext context}) {
    AppGlobals _appglobals = context.read<AppGlobals>();
    Customer? _customer = _appglobals.customer;
    if(_customer == null) {
      Fluttertoast.showToast(msg: "用户尚未登录");
      return false;
    }
    return true;
  }
}