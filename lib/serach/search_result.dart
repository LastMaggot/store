import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:store/Service/goods_service.dart';
import 'package:store/serach/search_goods_item.dart';
import 'package:store/comphonents/search_bar.dart';
import 'package:store/pojo/app_pojo.dart';
import 'package:store/style/app_style.dart';

class SearchResult extends StatefulWidget {
  String? searchContent;
  SearchResult({Key? key, this.searchContent}) : super(key: key);

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  TextEditingController searchController = TextEditingController();
  List<Widget> goodsItems = [];
  List<Goods> goodsList = [];

  void createGoodsItems() {
    for (Goods goods in goodsList) {
      goodsItems.add(SearchGoodsItem(goods: goods));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    if (widget.searchContent != null) {
      Future<List<Goods>> future =
          GoodsService.getGoodsByName(widget.searchContent!);
      future.then((value) {
        goodsList = value;
        createGoodsItems();
        setState(() {});
      });
    }
    super.initState();
  }

  void onSearch(String searchContent) {
    Fluttertoast.showToast(msg: "搜索$searchContent");
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SearchResult(
                  searchContent: searchContent,
                )));
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('搜索${widget.searchContent}'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // 返回箭头图标
          onPressed: () {
            Navigator.of(context).pop(); // 返回上一层
          },
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: AppSearchBar(
                  hintText: "请输入商品名",
                  onSearch: onSearch,
                  controller: searchController,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              (goodsItems != null && goodsItems.length != 0)
                  ? Column(
                      children: goodsItems,
                    )
                  : Container(
                      color: Colors.black12,
                      child: Center(
                        child: Text(
                          "没有找到对应的商品",
                          style: AppTextStyle.goodsWidgetName,
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
