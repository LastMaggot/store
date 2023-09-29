import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../comphonents/customer_search_bar.dart';
import 'customer_table.dart';

class CustomerSearchPage extends StatelessWidget {
  const CustomerSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    double left = width*0.05;
    return SizedBox(
      height: height,
      width: width*0.7,
      child: CustomerTable(),
      // child: Stack(
      //   children: [
      //     Positioned(
      //       left: left,
      //       width: width*0.7,
      //       child: CustomerSearchBar(),
      //     ),
      //     Positioned(
      //       left: left,
      //       top: height*0.3,
      //       width: width*0.7,
      //       height: height*0.7,
      //       child: CustomerTable(),
      //     ),
      //   ],
      // ),
    );
  }
}
