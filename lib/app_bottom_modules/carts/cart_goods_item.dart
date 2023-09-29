
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/code/all_image.dart';
import 'package:store/comphonents/overlay_window.dart';
import 'package:store/comphonents/rounded_rectangle.dart';
import 'package:store/global/app_globals.dart';
import 'package:store/goods/goods_detail.dart';
import 'package:store/pojo/app_pojo.dart';
import 'package:store/service/CartService.dart';
import 'package:store/service/order_service.dart';
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => GoodsDetail(goods: goods,showExtraButton: false,)));
              },
            ),
          ),
          Positioned(
            right: width*0.1,
            top: height*0.2,
            child: InkWell(
              onTap: () {
                Customer customer = context.read<AppGlobals>().customer!;
                OverlayWindow overlay2 = OverlayWindow();
                int price = 1 * goods.retailPrice!;
                overlay2.showConfirmationAlertDialog(context, title: "确定购买", content: "确定要购买这个产品吗",buttonMsg: "微信支付",buttonFunction: () {
                  Future future = OrderService.createOrder(customer.id!, goods.id!, 1, price);
                  future.then((value) {
                    if(value == true) {
                      CartService.deleteFromCart(goods.id!);
                    }
                  });
                });
              },
              child: Padding(
                padding: EdgeInsets.all(4),
                child: Text("购买"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
