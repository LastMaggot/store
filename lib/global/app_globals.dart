import 'package:flutter/material.dart';
import 'package:store/reference/references.dart';

class AppGlobals with ChangeNotifier {
  SharedPreferences cache;
  AppGlobals({required this.cache});
}