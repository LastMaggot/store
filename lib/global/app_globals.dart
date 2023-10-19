import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:store/reference/references.dart';
import 'package:store/pojo/app_pojo.dart';
import 'package:store/util/logs.dart';

class AppGlobals with ChangeNotifier {
  Customer? _customer;
  String? _token;
  final SharedPreferences cache;
  AppGlobals({required this.cache}) {
    _token = cache.getString("token");
    if (_token == null) {
      cache.setString("token", "null");
      _token = "null";
    }
    ;
    if (kDebugMode) {
      Logger.log(msg: _token!.toString());
    }
  }

  String? get token => _token;

  Customer? get customer => _customer;

  set token(String? value) {
    _token = value;
  }

  set customer(Customer? value) {
    _customer = value;
  }

  void clear() {
    _customer = null;
    _token = null;
    cache.setString("token", "null");
  }
}
