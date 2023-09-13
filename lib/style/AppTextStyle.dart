
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

@immutable
class AppTextStyle {
  static TextStyle drawerTitleStyle = const TextStyle(
    fontSize: 24,
    color: Colors.white,
  );
  static TextStyle vipTextStyle = const TextStyle(
    fontSize: 24,
    color: Colors.limeAccent,
  );
  static TextStyle topBarStyle = const TextStyle(
    fontSize: 20,
    color: Colors.black54,
  );
  static TextStyle goodsWidgetName = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  static TextStyle goodsWidgetPrice = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.red,
  );
}