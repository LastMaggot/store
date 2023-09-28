import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:store/admin/left_slide_menu.dart';

class LeftSlideMenu extends StatelessWidget {
  LeftSlideMenu({super.key});
  final PageController _pageController = PageController(initialPage: 0);
  final Random r = Random(3);

  void onSelect(MenuItemKeyType key) {
    print(key.toString());
    int page = r.nextInt(3);
    if (kDebugMode) {
      print(page);
    }
    _pageController.jumpToPage(page);
  }

  final List<MenuProp> items = [
    MenuProp(
        label: "用户管理",
        key: "用户管理",
        children: [
          MenuProp(label: "用户密码重置", key: "用户密码重置", icon: const Icon(Icons.send)),
          MenuProp(
              label: "注销用户账号", key: "注销用户账号", icon: const Icon(Icons.delete)),
          MenuProp(label: "用户信息查询", key: "用户信息查询", icon: const Icon(Icons.egg)),
        ],
        icon: const Icon(Icons.person)),
    MenuProp(
        label: "商品管理",
        key: "商品管理",
        children: [
          MenuProp(label: "新增商品", key: "新增商品", icon: const Icon(Icons.add)),
          MenuProp(label: "移除商品", key: "移除商品", icon: const Icon(Icons.remove)),
          MenuProp(
              label: "商品信息查询", key: "商品信息查询", icon: const Icon(Icons.search)),
        ],
        icon: const Icon(Icons.join_right)),
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
          child: PageView(controller: _pageController, children: const [
            Text("Page A"),
            Text("Page B"),
            Text("Page C"),
          ]),
        ),
      ],
    );
  }
}