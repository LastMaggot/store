import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:store/admin/customer/customer_search.dart';
import 'package:store/admin/goods/goods_search.dart';
import 'package:store/admin/goods/upload_goods.dart';
import 'package:store/admin/password_change.dart';
import 'package:store/comphonents/menu_base.dart';
class LeftSlideMenu extends StatelessWidget {
  LeftSlideMenu({super.key});
  final PageController _pageController = PageController(initialPage: 0);
  final Random r = Random(3);

  List<Widget> pages = [Container(child: Center(child: Text("请选择功能"),),),CustomerSearchPage(),GoodsSearchPage(),UploadGoodsFormPage(),PasswordChangePage()];

  void onSelect(MenuItemKeyType key) {
    if (kDebugMode) {
      print(key.toString());
    }
    int page = 0;
    switch(key) {
      case "用户管理":
        page = 1;
        break;
      case "商品信息查询":
        page = 2;
        break;
      case "新增商品":
        page = 3;
        break;
      case "账号设置":
        page = 4;
        break;
      default: page = 0;
    }
    _pageController.jumpToPage(page);
  }

  final List<MenuProp> items = [
    MenuProp(
        label: "用户管理",
        key: "用户管理",
        icon: const Icon(Icons.person)),
    MenuProp(
        label: "商品管理",
        key: "商品管理",
        children: [
          MenuProp(label: "新增商品", key: "新增商品", icon: const Icon(Icons.add)),
          MenuProp(
              label: "商品信息查询", key: "商品信息查询", icon: const Icon(Icons.search)),
        ],
        icon: const Icon(Icons.join_right)),
    MenuProp(
        label: "账号设置",
        key: "账号设置",
        icon: const Icon(Icons.person)),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Menu(
          items: items,
          collapsed: true,
          onSelect: onSelect,
        ),
        Expanded(
          child: PageView(controller: _pageController, children: pages,
          ),
        ),
      ],
    );
  }
}