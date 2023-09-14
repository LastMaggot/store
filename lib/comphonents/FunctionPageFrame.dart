import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store/pojo/app_pojo.dart';

class FunctionPageFrame extends StatefulWidget {
  Widget? body;
  String? title;
  FunctionPageFrame({Key? key, this.body, this.title}) : super(key: key);

  @override
  _FunctionPageFrameState createState() => _FunctionPageFrameState();
}

class _FunctionPageFrameState extends State<FunctionPageFrame> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.title == null ? Text('未命名') : Text(widget.title!),
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // 返回箭头图标
          onPressed: () {
            Navigator.of(context).pop(); // 返回上一层
          },
        ),
      ),
      body: widget.body,
    );
  }
}
