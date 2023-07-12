
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

@immutable
class Logger {
  static void httpRequestFailure() async {
    if (kDebugMode) {
      print("链接服务器失败 \n");
    }
  }

  static void log({required String msg}) async {
    if (kDebugMode) {
      print("[Message]$msg \n");
    }
  }

  static void warning({required String msg}) async {
    if (kDebugMode) {
      print("[Warning]$msg \n");
    }
  }

  static void error({required String msg}) async {
    if (kDebugMode) {
      print("[Error]$msg");
    }
  }

}