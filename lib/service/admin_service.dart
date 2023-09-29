import 'dart:js_interop';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:store/pojo/app_pojo.dart';
import 'package:store/request/admin_request.dart';
import 'package:store/util/data_processor.dart';
import 'package:store/util/logs.dart';

class AdminService {

  static Future<Customer?> signIn(String account, String password) async {
    Response response = await AdminRequest.signIn(account, password);
    Result<Customer?> result = Result.fromResponse(response,constructor: Customer.fromJson);
    if(result.isValid()) {
      return result.data;
    }
    return result.data;
  }

  static Future<List<Customer>> getAllCustomerInfo() async {
    Response response = await AdminRequest.getAllCustomerInfo();
    DataProcessor<Customer> dataProcessor = DataProcessor<Customer>();
    List<Customer> customerList = dataProcessor.listDataFromResponse(response,constructor: Customer.fromJson);
    if(kDebugMode) {
      for (Customer customer in customerList) {
        Logger.log(msg: customer.toString());
      }
    }
    return customerList;
  }

  static Future<List<Customer>> getCustomerInfoById(int id) async {
    Response response = await AdminRequest.getCustomerInfoById(id);
    DataProcessor<Customer> dataProcessor = DataProcessor<Customer>();
    List<Customer> customerList = dataProcessor.listDataFromResponse(response,constructor: Customer.fromJson);
    if(kDebugMode) {
      for (Customer customer in customerList) {
        Logger.log(msg: customer.toString());
      }
    }
    return customerList;
  }

  static Future<List<Customer>> getCustomerInfoByName(String name) async {
    Response response = await AdminRequest.getCustomerInfoByName(name);
    DataProcessor<Customer> dataProcessor = DataProcessor<Customer>();
    List<Customer> customerList = dataProcessor.listDataFromResponse(response,constructor: Customer.fromJson);
    if(kDebugMode) {
      for (Customer customer in customerList) {
        Logger.log(msg: customer.toString());
      }
    }
    return customerList;
  }

  static Future<void> deleteCustomerById(int id) async {
    Response response = await AdminRequest.deleteCustomerById(id);
    Result result = Result.fromResponse(response);
    if(result.isValid()) {
      if(kDebugMode) {
        Logger.log(msg: '成功删除');
        Fluttertoast.showToast(msg: "成功删除");
      }
    }
  }

  static Future<void> resetPassword(String account) async {
    Response response = await AdminRequest.resetPassword(account);
    Result result = Result.fromResponse(response);
    if(result.isValid()) {
      if(kDebugMode) {
        Logger.log(msg: '成功重置');
        Fluttertoast.showToast(msg: "成功重置");
      }
    }
  }

  static Future<void> resetAdminPassword(String account, String password) async {
    Response response = await AdminRequest.resetAdminPassword(account,password);
    Result result = Result.fromResponse(response);
    if(result.isValid()) {
      if(kDebugMode) {
        Logger.log(msg: '成功修改');
        Fluttertoast.showToast(msg: "成功修改");
      }
    }
  }

  static Future<List<Goods>> getAllGoods() async {
    Response response = await AdminRequest.getAllGoods();
    DataProcessor<Goods> dataProcessor = DataProcessor<Goods>();
    List<Goods> goodsList = dataProcessor.listDataFromResponse(response,constructor: Goods.fromJson);
    if(kDebugMode) {
      for (Goods goods in goodsList) {
        Logger.log(msg: goods.toString());
      }
    }
    return goodsList;
  }

  static Future<List<Goods>> getGoodsById(int id) async {
    Response response = await AdminRequest.getGoodsById(id);
    DataProcessor<Goods> dataProcessor = DataProcessor<Goods>();
    List<Goods> goodsList = dataProcessor.listDataFromResponse(response,constructor: Goods.fromJson);
    if(kDebugMode) {
      for (Goods goods in goodsList) {
        Logger.log(msg: goods.toString());
      }
    }
    return goodsList;
  }

  static Future<List<Goods>> getGoodsByName(String name) async {
    Response response = await AdminRequest.getGoodsByName(name);
    DataProcessor<Goods> dataProcessor = DataProcessor<Goods>();
    List<Goods> goodsList = dataProcessor.listDataFromResponse(response,constructor: Goods.fromJson);
    if(kDebugMode) {
      for (Goods goods in goodsList) {
        Logger.log(msg: goods.toString());
      }
    }
    return goodsList;
  }

  static Future<void> addGoods(Goods goods) async {
    Response response = await AdminRequest.addGoods(goods);
    Result result = Result.fromResponse(response);
    if(result.isValid()) {
      if(kDebugMode) {
        Logger.log(msg: "成功提交");
      }
      Fluttertoast.showToast(msg: "成功提交");
    }
  }

  static Future<void> delGoods(int id) async {
    Response response = await AdminRequest.delGoods(id);
    Result result = Result.fromResponse(response);
    if(result.isValid()) {
      if(kDebugMode) {
        Logger.log(msg: '成功删除');
        Fluttertoast.showToast(msg: "成功删除");
      }
    }
  }

  static Future<void> updGoods(Goods goods) async {
    Response response = await AdminRequest.updGoods(goods);
    Result result = Result.fromResponse(response);
    if(result.isValid()) {
      if(kDebugMode) {
        Logger.log(msg: '成功修改');
        Fluttertoast.showToast(msg: "成功修改");
      }
    }
  }

}