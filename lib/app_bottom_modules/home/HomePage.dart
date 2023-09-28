import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:store/comphonents/search_bar.dart';
import 'package:store/serach/search_result.dart';
import 'package:store/util/logs.dart';
import 'package:store/appPages.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();

  void onSearch(String searchContent) {
    Fluttertoast.showToast(msg: "搜索$searchContent");
    Navigator.push(context, MaterialPageRoute(builder: (context) => SearchResult(searchContent: searchContent,)));
    return;
  }

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    Logger.log(msg: size.toString());
    return SingleChildScrollView(
      child: Container(
        width: width,
        height: height,
        color: Colors.white,
        child: Stack(
          children: [
            Positioned(
              left: width*0.1,
              top: height*0.1,
              width: width*0.8,
              height: height*0.05,
              child: AppSearchBar(
                hintText: "请输入商品名",
                width: width*0.8,
                height: height*0.05,
                controller: searchController,
                onSearch: onSearch,
              ),
            ),
            ProjectIntroducePage(),
          ],
        ),
      ),
    );
  }
}
