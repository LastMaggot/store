import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:store/code/all_image.dart';
import 'package:store/comphonents/FunctionPageFrame.dart';
import 'package:store/comphonents/overlay_window.dart';
import 'package:store/comphonents/rounded_rectangle.dart';
import 'package:store/global/app_globals.dart';
import 'package:store/pojo/app_pojo.dart';
import 'package:store/service/CartService.dart';
import 'package:store/service/customer_service.dart';
import 'package:store/style/app_style.dart';

class GoodsDetail extends StatefulWidget {
  Goods goods;
  bool showExtraButton;
  GoodsDetail({Key? key, required this.goods, this.showExtraButton = true}) : super(key: key);

  @override
  _GoodsDetailState createState() => _GoodsDetailState();
}

class _GoodsDetailState extends State<GoodsDetail> {
  OverlayWindow overlayWindow = OverlayWindow();

  void addToCarts() async {
    if (CustomerService.hasLogin(context: context)) {
      Customer customer = context.read<AppGlobals>().customer!;
      Future future = CartService.addToCart(customer.id!, widget.goods.id!, 1);
      return;
    }
    showOverlayWindow();
  }

  void buy() async {
    if (CustomerService.hasLogin(context: context)) {
      Customer customer = context.read<AppGlobals>().customer!;
      if(widget.goods.inventory! < 1 ) {
        Fluttertoast.showToast(msg: "商品库存不足");
      }
      return;
    }
    showOverlayWindow();
  }

  void showOverlayWindow() {
    overlayWindow.showConfirmationAlertDialog(context,
        title: "用户登录检测",
        content: "现在就去登入吗？",
        buttonMsg: "去登录", buttonFunction: () {
      Navigator.popAndPushNamed(context, '/sign');
    });
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    try {
      overlayWindow.close(context: context);
    } catch (e) {}
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    overlayWindow.buildQuickTips(
        context: context,
        msg: "检测到您尚未进行登入",
        buttonMsg: "去登录",
        buttonFunction: () {
          Navigator.pushNamed(context, '/sign');
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size windowSize = MediaQuery.of(context).size;
    double height = windowSize.height;
    double width = windowSize.width;
    return FunctionPageFrame(
      title: '商品详情',
      body: Center(
        child: Container(
          width: 1000,
          child: Stack(
            children: [
              Positioned(
                left: 10,
                top: 10,
                height: 400,
                width: 400,
                child: Image(
                  image: NoImage.image,
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                left: 420,
                top: 10,
                height: 40,
                child: Text(
                  '${widget.goods.name}',
                  style: AppTextStyle.goodsWidgetName,
                ),
              ),
              Positioned(
                left: 420,
                top: 50,
                height: 40,
                child: Text(
                  '${widget.goods.version}',
                  style: AppTextStyle.goodsWidgetName,
                ),
              ),
              Positioned(
                left: 420,
                top: 100,
                height: 90,
                child: Text(
                  '${widget.goods.description}',
                  style: AppTextStyle.goodsWidgetName,
                ),
              ),
              Positioned(
                left: 420,
                top: 200,
                height: 40,
                child: Text(
                  '库存 ${widget.goods.retailPrice} 件',
                  style: AppTextStyle.goodsWidgetName,
                ),
              ),
              Positioned(
                left: 10,
                top: 450,
                height: 40,
                child: Text(
                  '制造商：${widget.goods.manufacturer}',
                  style: AppTextStyle.goodsWidgetName,
                ),
              ),
              Positioned(
                left: 10,
                top: 500,
                height: 40,
                child: Text(
                  '店铺:${widget.goods.publishingHouse}',
                  style: AppTextStyle.goodsWidgetName,
                ),
              ),
              Positioned(
                left: 10,
                top: 550,
                height: 40,
                child: Text(
                  '参考价格:${widget.goods.retailPrice}¥',
                  style: AppTextStyle.goodsWidgetPrice,
                ),
              ),
              widget.showExtraButton==true?Positioned(
                bottom: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RoundedRectangle(
                        width: width * 0.35,
                        height: height * 0.1,
                        backgroundColor: Colors.amber,
                        child: GestureDetector(
                          onTap: addToCarts,
                          child: Text(
                            '加入购物车',
                            style: AppTextStyle.addToCarts,
                          ),
                        )),
                    RoundedRectangle(
                        height: height * 0.1,
                        width: width * 0.35,
                        backgroundColor: Colors.redAccent,
                        child: GestureDetector(
                          onTap: buy,
                          child: Text(
                            '购买',
                            style: AppTextStyle.buy,
                          ),
                        )),
                  ],
                ),
              ):Container(),
            ],
          ),
        ),
      ),
    );
  }
}
