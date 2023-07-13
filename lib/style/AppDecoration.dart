import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

@immutable
class AppDecoration {

  static InputDecoration inputDecorationFromLH({String? labelText,String? hintText,IconData iconData = Icons.person}) {
    return InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: Icon(iconData),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
          ),
        )
    );
  }
}
