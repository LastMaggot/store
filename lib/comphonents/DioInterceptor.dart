
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:store/util/logs.dart';

class DioInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if(kDebugMode) {
      Logger.log(msg: options.uri.toString());
      String data = options.data==null?"null":options.data.toString();
      Logger.log(msg: data);

    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      Logger.log(msg: err.response.toString());
      Logger.error(msg:err.toString());
      Fluttertoast.showToast(msg: "联系服务器失败");
    }
    super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if(kDebugMode) {
      Logger.log(msg: response.data.toString());
    }
    super.onResponse(response, handler);
  }
}