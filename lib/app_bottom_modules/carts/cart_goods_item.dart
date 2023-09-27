
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store/code/all_image.dart';
import 'package:store/comphonents/rounded_rectangle.dart';
import 'package:store/goods/goods_detail.dart';
import 'package:store/pojo/app_pojo.dart';
import 'package:store/style/app_style.dart';

class CartGoodsItem extends StatelessWidget {
  Goods goods;

  CartGoodsItem({Key? key, required this.goods}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    double imgRightBoundary = width*0.1 + height*0.2;
    return RoundedRectangle(
      height: height*0.3,
      backgroundColor: Colors.white,
      child: Stack(
        children: [
          Positioned(
            left: width*0.1,
            top: height*0.02,
            height: height*0.05,
            child: Text(goods.publishingHouse!,style: AppTextStyle.cartGoodsItemTitle,),
          ),
          Positioned(
            left: width*0.1,
            top: height*0.1,
            height: height*0.17,
            width: height*0.17,
            child: Image(image: NoImage.image,fit: BoxFit.fill,),
          ),
          Positioned(
            left: imgRightBoundary,
            top: height * 0.1,
            child: Text(goods.name!,style: AppTextStyle.cartGoodsItemName,maxLines: 1,),
          ),
          Positioned(
            left: imgRightBoundary,
            bottom: height*0.05,
            child: Text("¥${goods!.purchaseCost}",style: AppTextStyle.goodsWidgetPrice,maxLines: 1,),
          ),
          Positioned(
            left: width*0.1,
            top: height*0.1,
            bottom: height*0.1,
            right: width*0.1,
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => GoodsDetail(goods: goods)));
              },
            ),
          ),
        ],
      ),
    );
  }
}
