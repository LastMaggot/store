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

  static bool logout({required BuildContext context}) {
    try {
      AppGlobals _appglobals = context.read<AppGlobals>();
      _appglobals.clear();
      return true;
    } catch (e) {
      Fluttertoast.showToast(msg: "消除用户信息失败");
      return false;
    }
  }

  static Future<bool> signUp(String account, String password, String email) async {
    Response response = await CustomerRequest.signUp(account, password, email);
    Result result = Result.fromResponse(response);
    if(result.isValid()) {
      Fluttertoast.showToast(msg: "注册成功");
      return true;
    }
    Fluttertoast.showToast(msg: "注册失败");
    return false;
  }

  static Future<bool> forgetPassword(String account, String email) async {
    Response response = await CustomerRequest.forgetPassword(account,email);
    Result result = Result.fromResponse(response);
    if(result.isValid()) {
      Fluttertoast.showToast(msg: "邮件已发送");
      return true;
    }
    Fluttertoast.showToast(msg: "邮件发送失败，无效的邮箱");
    return false;
  }
}