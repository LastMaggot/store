import 'dart:js_interop';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store/admin/sign/admin_sign_in_form.dart';
import 'package:store/app_drawer_module/sign/sign_in/sign_in_form.dart';
import 'package:store/app_drawer_module/sign/sign_up/sign_up_form.dart';
import 'package:store/style/app_style.dart';

class AdminSignPage extends StatefulWidget {
  Widget? body;

  AdminSignPage({Key? key, this.body}) : super(key: key);

  @override
  AdminSignPageState createState() => AdminSignPageState();
}

class AdminSignPageState extends State<AdminSignPage> {
  Widget? body;

  @override
  void initState() {
    widget.body == null ? body = AdminSignInForm() : body = widget.body;
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
              const Text("登录蓝天购物平台后台管理系统"),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, "/sign");
            },
            child: Text(
              "用户登录",
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
        ),
      ),
    );
  }
}
