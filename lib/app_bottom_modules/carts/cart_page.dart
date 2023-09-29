
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:store/Service/goods_service.dart';
import 'package:store/app_bottom_modules/carts/cart_goods_item.dart';
import 'package:store/comphonents/overlay_window.dart';
import 'package:store/global/app_globals.dart';
import 'package:store/pojo/app_pojo.dart';
import 'package:store/service/CartService.dart';

class CartPage extends StatefulWidget {

  CartPage({Key? key}) : super(key: key);

  @override
  CartPageState createState() => CartPageState();
}

class CartPageState extends State<CartPage> with AutomaticKeepAliveClientMixin {
  List<Goods> goodsList = [];
  List<CartGoodsItem> itemList = [];
  Customer? customer;
  void initGoodsList() {
    Future future = CartService.getCartGoods(customer!.id!);
    future.then((value) {
      goodsList = value;
      for(Goods g in goodsList) {
        itemList.add(CartGoodsItem(goods: g,));
      }
      setState(() {

      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    customer = context.read<AppGlobals>().customer;
    if(customer == null) {
      OverlayWindow overlayWindow = OverlayWindow();
      overlayWindow.showConfirmationAlertDialog(context,
          title: "用户登录检测",
          content: "现在就去登入吗？",
          buttonMsg: "去登录", buttonFunction: () {
            Navigator.popAndPushNamed(context, '/sign');
          });
      setState(() {});
    }
    else {initGoodsList();}
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    return Container(
      color: Colors.black12,
      child: SingleChildScrollView(
        child: Column(
          children: itemList,
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}