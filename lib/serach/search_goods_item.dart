import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store/code/all_image.dart';
import 'package:store/goods/goods_detail.dart';
import 'package:store/style/app_style.dart';
import 'package:store/pojo/app_pojo.dart';

class SearchGoodsItem extends StatelessWidget {
  Goods goods;

  SearchGoodsItem({Key? key, required this.goods}) : super(key: key);

  void jumpToDetail(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => GoodsDetail(goods: goods)));
    return;
  }

  @override
  Widget build(BuildContext context) {
    Size windowSize = MediaQuery.of(context).size;
    double width = windowSize.width;
    double height = windowSize.height;
    return Container(
      height: 200,
      decoration: BoxDecoration(
          color: Colors.white60,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            width: 1.0,
            color: Colors.black12,
          )),
      child: GestureDetector(
        onTap: () {
          jumpToDetail(context);
        },
        child: Stack(
          children: [
            Positioned(
              left: 10,
              top: 10,
              child: Image(
                image: NoImage.image,
                width: 200,
                height: 180,
              ),
            ),
            Positioned(
              left: 200,
              top: 10,
              child: SizedBox(
                height: 40,
                child: Text(
                  goods.name!,
                  style: AppTextStyle.goodsWidgetName,
                  maxLines: 2,
                  overflow: TextOverflow.clip,
                ),
              ),
            ),
            Positioned(
              left: 200,
              top: 150,
              child: SizedBox(
                height: 30,
                child: Image(
                  image: CNY.image,
                  height: 30,
                  width: 30,
                ),
              ),
            ),
            Positioned(
              left: 220,
              top: 150,
              child: SizedBox(
                height: 30,
                child: Text(
                  goods.retailPrice.toString(),
                  style: AppTextStyle.goodsWidgetPrice,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
