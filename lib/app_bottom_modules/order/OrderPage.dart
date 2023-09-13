import 'package:flutter/cupertino.dart';
import 'package:store/app_bottom_modules/order/services/order_services.dart';
import 'package:store/global/app_globals.dart';
import 'package:store/pojo/app_pojo.dart';
import 'package:store/reference/references.dart';


class OrderPage extends StatefulWidget {

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  int? userId;
  List<Order> orderList = [];
  OrderServices orderServices = OrderServices();

  @override
  void initState() {
    AppGlobals appGlobals = context.read<AppGlobals>();
    SharedPreferences cache = appGlobals.cache;
    userId = cache.getInt('userId');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    return Container(
      width: width*0.9,
      height: height*0.9,
    );
  }
}