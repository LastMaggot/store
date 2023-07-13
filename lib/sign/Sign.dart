import 'dart:js_interop';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:store/sign/sign_in/sign_in_form.dart';
import 'package:store/sign/sign_up/sign_up_form.dart';
import 'package:store/style/app_style.dart';
import 'package:store/util/logs.dart';

class SignPage extends StatefulWidget {
  Widget? body;

  SignPage({Key? key, this.body}) : super(key: key);

  @override
  SignPageState createState() => SignPageState();
}

class SignPageState extends State<SignPage> {
  Widget? body;

  @override
  void initState() {
    widget.body == null ? body = SignInForm() : body = widget.body;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double containerWidth = size.width * 0.8;
    double containerHeight = size.height * 0.6;
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const FlutterLogo(
                size: 35,
              ),
              const Text("登录蓝天购物平台"),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, "/admin");
            },
            child: Text(
              "管理员登录",
              style: AppTextStyle.topBarStyle,
            ),
          ),
        ],
      ),
      body: Center(
          child: Container(
        alignment: Alignment.center,
        width: containerWidth,
        height: containerHeight,
        child: body,
      )),
    );
  }
}
