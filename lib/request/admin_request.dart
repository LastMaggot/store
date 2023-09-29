import 'package:store/constants/Constants.dart';
import 'package:store/pojo/app_pojo.dart';
import 'package:store/util/logs.dart';
import 'package:dio/dio.dart';


class AdminRequest {

  static String adminReqUrl = requestUrl + "/admin";

  static Future<Response> signIn(String account, String password) async {
    Response response;
    response = await dio.get('$adminReqUrl/signIn',queryParameters: {'account':account,'password':password});
    return response;
  }

  static Future<Response> getAllCustomerInfo() async {
    Response response;
    response = await dio.get('$adminReqUrl/getAllCustomerInfo');
    return response;
  }

  static Future<Response> getCustomerInfoById(int id) async {
    Response response;
    response = await dio.get('$adminReqUrl/getCustomerInfoById',queryParameters: {'id':id});
    return response;
  }

  static Future<Response> getCustomerInfoByName(String name) async {
    Response response;
    response = await dio.get('$adminReqUrl/getCustomerInfoByName',queryParameters: {'name':name});
    return response;
  }

  static Future<Response> deleteCustomerById(int id) async {
    Response response;
    response = await dio.delete('$adminReqUrl/deleteCustomerById',queryParameters: {'id':id});
    return response;
  }

  static Future<Response> resetPassword(String account) async {
    Response response;
    response = await dio.post('$adminReqUrl/resetPassword',queryParameters: {'account':account});
    return response;
  }

  static Future<Response> resetAdminPassword(String account,String password) async {
    Response response;
    response = await dio.post('$adminReqUrl/resetAdminPassword',data: {'account':account,'password':password});
    return response;
  }

  static Future<Response> getAllGoods() async {
    Response response;
    response = await dio.get('$adminReqUrl/getAllGoods');
    return response;
  }

  static Future<Response> getGoodsById(int id) async {
    Response response;
    response = await dio.get('$adminReqUrl/getGoodsById',queryParameters: {'id':id});
    return response;
  }

  static Future<Response> getGoodsByName(String name) async {
    Response response;
    response = await dio.get('$adminReqUrl/getGoodsByName',queryParameters: {'name':name});
    return response;
  }

  static Future<Response> addGoods(Goods goods) async {
    Response response;
    response = await dio.post('$adminReqUrl/addGoods', data: goods.toJson());
    return response;
  }
  
  static Future<Response> delGoods(int id) async {
    Response response;
    response = await dio.delete('$adminReqUrl/delGoods',queryParameters: {'id':id});
    return response;
  }
  
  static Future<Response> updGoods(Goods goods) async {
    Response response;
    response = await dio.post('$adminReqUrl/updGoods',data: goods.toJson());
    return response;
  }

}