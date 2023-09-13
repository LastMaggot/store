import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Result<T> {
  int code; //1 成功 , 0 失败
  String msg; //提示信息
  T? data; //数据 data

  Result({required this.code, required this.msg, required this.data});

  factory Result.fromResponse(Response response,{T Function(Map<String, dynamic>)? constructor}) {
    Map<String,dynamic> json = response.data;
    int code = json['code'] as int;
    return Result(
      code: code,
      msg: json['msg'] as String,
      data: code==1&&constructor!=null?constructor(json['data']):json['data'] as T?,
    );
  }

  factory Result.listDataFromResponse(Response response,{T Function(List<dynamic>)? constructor}) {
    Map<String,dynamic> json = response.data;
    int code = json['code'] as int;
    return Result(
      code: code,
      msg: json['msg'] as String,
      data: code==1&&constructor!=null?constructor(json['data']):json['data'] as T?,
    );
  }

  bool isValid() {
    if(code==1) return true;
    Fluttertoast.showToast(msg: msg);
    return false;
  }

  Map<String, dynamic> toJson() => {
    'code': code,
    'msg': msg,
    'data': data,
  };

  @override
  String toString() {
    return "Result{code: $code, msg: $msg, data: ${data.toString()}";
  }
}
