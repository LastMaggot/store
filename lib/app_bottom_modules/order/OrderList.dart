import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/Service/goods_service.dart';
import 'package:store/global/app_globals.dart';
import 'package:store/pojo/customer.dart';
import 'package:store/pojo/order.dart';
import 'package:store/service/admin_service.dart';
import 'package:store/service/order_service.dart';

import '../../pojo/goods.dart';


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

        return FutureBuilder<List<Goods>>(
          future: AdminService.getGoodsById(order.goods_id!),
          builder: (context, goodsSnapshot) {
            if (goodsSnapshot.connectionState == ConnectionState.waiting) {
              // 当商品信息正在加载时显示加载状态
              return CircularProgressIndicator();
            } else if (goodsSnapshot.hasError || goodsSnapshot.data!.isEmpty) {
              // 当加载商品信息出错时显示错误消息
              return Text('Error loading goods');
            } else if (goodsSnapshot.hasData) {
              Goods goods = goodsSnapshot.data!.first;

              return FutureBuilder<List<Customer>>(
                future: AdminService.getCustomerInfoById(order.user_id!),
                builder: (context, customerSnapshot) {
                  if (customerSnapshot.connectionState == ConnectionState.waiting) {
                    // 当客户信息正在加载时显示加载状态
                    return CircularProgressIndicator();
                  } else if (customerSnapshot.hasError) {
                    // 当加载客户信息出错时显示错误消息
                    return Text('Error loading customer');
                  } else if (customerSnapshot.hasData) {
                    Customer customer = customerSnapshot.data!.first;
                    return Card(
                      margin: EdgeInsets.all(8),
                      child: ListTile(
                        title: Text('Order ID: ${order.id}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('User Name: ${customer.username}'),
                            Text('Goods Name: ${goods.name}'),
                            Text('Quantity: ${order.num}'),
                            Text('Price: ${order.price}'),
                            Text('Date: ${order.create_time!.toLocal().toString()}'),
                          ],
                        ),
                      ),
                    );
                  }

                  // 默认返回一个空的容器
                  return Container();
                },
              );
            }

            // 默认返回一个空的容器
            return Container();
          },
        );
      },
    );
  }
}
