import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store/comphonents/search_bar.dart';
import 'package:store/util/logs.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    Logger.log(msg: size.toString());
    return SingleChildScrollView(
      child: Container(
        width: width,
        height: height,
        color: Colors.white,
        child: Stack(
          children: [
            Positioned(
              left: width*0.1,
              top: height*0.1,
              width: width*0.8,
              height: height*0.05,
              child: AppSearchBar(
                hintText: "请输入商品名",
                width: width*0.8,
                height: height*0.05,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
