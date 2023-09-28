
import 'package:flutter/cupertino.dart';
import 'package:store/admin/left_slide_menu.dart';
import 'package:store/comphonents/FunctionPageFrame.dart';
import 'package:store/comphonents/menu_base.dart';

class AdminPage extends StatefulWidget {

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {

  @override
  Widget build(BuildContext context) {
    return FunctionPageFrame(
      body: LeftSlideMenu(),
      title: "蓝天购物平台后台管理系统",
    );
  }
}

