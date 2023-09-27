import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:store/util/logs.dart';

class ResponseUtil {
  static bool responseIsValid(Response response) {
    if(response.statusCode != 200) {
      Fluttertoast.showToast(msg: "与服务器建立链接失败");
      return false;
    }
    return true;
  }

  static Response connectionError() {
    Logger.error(msg: "发出Http请求失败");
    return Response(
      statusCode: 400,
      statusMessage: "与服务器建立链接失败",
      requestOptions: RequestOptions(),
    );
  }
}

