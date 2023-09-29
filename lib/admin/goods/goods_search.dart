import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'goods_table.dart';

class GoodsSearchPage extends StatelessWidget {
  const GoodsSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    double left = width*0.05;
    return SizedBox(
      height: height,
      width: width*0.7,
      child: GoodsTable(),
    );
  }
}
