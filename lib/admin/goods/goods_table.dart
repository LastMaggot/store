import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:store/admin/goods/goods_edit_page.dart';
import 'package:store/admin/goods/upload_goods.dart';
import 'package:store/pojo/app_pojo.dart';
import 'package:store/service/admin_service.dart';

import '../../comphonents/overlay_window.dart';

class GoodsTable extends StatefulWidget {
  const GoodsTable({super.key});

  @override
  _GoodsTableState createState() => _GoodsTableState();
}

class _GoodsTableState extends State<GoodsTable> {
  String _selectedOption = 'id';
  TextEditingController _searchController = TextEditingController();


  List<Goods> goodsList = [];
  List<DataRow> goodsDataRows = [];

  void makeDataRows() {
    int idx = 0;
    for (Goods goods in goodsList) {
      goodsDataRows.add(
        DataRow(cells: [
          DataCell(Text(goods.id.toString())),
          DataCell(Text(goods.name.toString())),
          DataCell(Text(goods.manufacturer.toString())),
          DataCell(Text(goods.pictureUrl.toString())),
          DataCell(Text(goods.version.toString())),
          DataCell(Text(goods.description.toString())),
          DataCell(Text(goods.publishingHouse.toString())),
          DataCell(Text(goods.purchaseCost.toString())),
          DataCell(Text(goods.retailPrice.toString())),
          DataCell(Text(goods.inventory.toString())),
          DataCell(Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => GoodsEditPage(goods: goods)));
                },
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('编辑'),
                ),
              ),
              InkWell(
                onTap: () {
                  OverlayWindow overlay = OverlayWindow();
                  overlay.showConfirmationAlertDialog(context, title: '删除商品', content: "确定要删除商品吗？",buttonMsg: "确定删除",buttonFunction: () {
                    Future future = AdminService.delGoods(goods.id!);
                    future.then((value) {
                      goodsDataRows.removeAt(idx);
                      setState(() {

                      });
                    });
                  });
                },
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('删除'),
                ),
              ),
            ],
          )),
        ]),
      );
      idx++;
    }
  }

  void search(String option, String text) {
    Future future;
    if (option == "id") {
      int id = int.parse(text);
      future = AdminService.getGoodsById(id);
    }
    else {
      future = AdminService.getGoodsByName(text);
    }
    future.then((value) {
      this.goodsList = value;
      if(goodsList == null) {
        Fluttertoast.showToast(msg: "未找到对应数据");
        return;
      }
      makeDataRows();
      setState(() {

      });
      return;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    return Column(
      children: [
        Container(
          width: size.width * 0.7,
          height: 75,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey), // 边框颜色
            borderRadius: BorderRadius.circular(10.0), // 圆角
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                DropdownButton<String>(
                  value: _selectedOption,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedOption = newValue!;
                    });
                  },
                  items: <String>['id', '商品名'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: '输入搜索关键词',
                      border: InputBorder.none, // 隐藏输入框的边框
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    // 处理搜索逻辑
                    String selectedOption = _selectedOption;
                    String searchText = _searchController.text;
                    goodsDataRows = [];
                    search(selectedOption, searchText);
                    // 在这里使用selectedOption和searchText执行搜索操作
                  },
                ),
              ],
            ),
          ),
        ),
        Container(
          width: width * 0.7,
          height: height * 0.7,
          padding: EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: DataTable(
              columns: [
                DataColumn(label: Text('ID')),
                DataColumn(label: Text('名称')),
                DataColumn(label: Text('制造商')),
                DataColumn(label: Text('图片')),
                DataColumn(label: Text('版本')),
                DataColumn(label: Text('描述')),
                DataColumn(label: Text('出版社')),
                DataColumn(label: Text('进货成本')),
                DataColumn(label: Text('零售价')),
                DataColumn(label: Text('库存')),
                DataColumn(label: Text('操作')),
              ],
              rows: goodsDataRows,
            ),
          ),
        ),
      ],
    );
  }
}
