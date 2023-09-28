
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:store/Service/goods_service.dart';
import 'package:store/app_bottom_modules/carts/cart_goods_item.dart';
import 'package:store/pojo/app_pojo.dart';

class CartPage extends StatefulWidget {

  CartPage({Key? key}) : super(key: key);

  @override
  CartPageState createState() => CartPageState();
}

class CartPageState extends State<CartPage> with AutomaticKeepAliveClientMixin {
  List<Goods> goodsList = [];
  List<CartGoodsItem> itemList = [];

  void initGoodsList() {
    Future future = GoodsService.getAllGoods();
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
    initGoodsList();
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