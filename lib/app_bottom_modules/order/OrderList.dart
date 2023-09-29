import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/global/app_globals.dart';
import 'package:store/pojo/customer.dart';
import 'package:store/pojo/order.dart';
import 'package:store/service/order_service.dart';


class OrderListWidget extends StatefulWidget {

  @override
  _OrderListWidgetState createState() => _OrderListWidgetState();
}

class _OrderListWidgetState extends State<OrderListWidget> {
  List<Order> orders = [];
  Customer? customer;
  
  @override
  void initState() {
    // TODO: implement initState
    customer = context.read<AppGlobals>().customer!;
    Future<List<Order>> future = OrderService.getOrders(customer!.id!);
    future.then((value){
      orders = value;
      setState(() {

      });
    });
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        Order order = orders[index];
        return Card(
          margin: EdgeInsets.all(8),
          child: ListTile(
            title: Text('Order ID: ${order.id}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('User ID: ${order.user_id}'),
                Text('Goods ID: ${order.goods_id}'),
                Text('Quantity: ${order.num}'),
                Text('Price: ${order.price}'),
                Text('Date: ${order.create_time}'),
              ],
            ),
          ),
        );
      },
    );
  }
}
