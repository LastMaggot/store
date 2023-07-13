import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:store/util/logs.dart';

class AppSearchBar extends StatelessWidget {
  TextEditingController? controller;
  double width;
  double height;
  String? labelText;
  String? hintText;
  void Function()? onPressed;
  void Function()? onSearch;

  void _onPressed() {
    onPressed;
    Fluttertoast.showToast(msg: "按下搜索框");
  }

  void _clearInput() {
    if (controller == null) {
      Logger.log(msg: "未绑定控制器");
      Fluttertoast.showToast(msg: "未绑定控制器");
      return;
    }
    controller!.text = "";
    Fluttertoast.showToast(msg: "删除文本");
    return;
  }

  AppSearchBar({Key? key, this.width = 250, this.height = 32, this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller = (controller == null)? controller : TextEditingController();
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.circular(height)),
      child: TextField(
          autofocus: false,
          controller: controller,
          decoration:
          InputDecoration(
            labelText: labelText ?? "商品名",
              hintText: hintText ?? "请输入搜索词",
              hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
              contentPadding: EdgeInsets.only(bottom: height / 3),
              border: InputBorder.none,
              icon: Padding(
                  padding: const EdgeInsets.only(left: 10, top: 0),
                  child: Icon(
                    Icons.search,
                    size: 24,
                    color: Theme.of(context).primaryColor,
                  )),
              suffixIcon: IconButton(
                icon: const Icon(
                  Icons.close,
                  size: 17,
                ),
                onPressed: () {
                  _clearInput();
                },
                splashColor: Theme.of(context).primaryColor,
              )),
          onEditingComplete: () {
            this.onSearch;
          }),
    );
  }
}
