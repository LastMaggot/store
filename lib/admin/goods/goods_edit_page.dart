import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:store/pojo/app_pojo.dart';
import 'package:store/service/admin_service.dart';

class GoodsEditPage extends StatefulWidget {
  final Goods goods;

  GoodsEditPage({Key? key, required this.goods}) : super(key: key);

  @override
  _GoodsEditPageState createState() => _GoodsEditPageState();
}

class _GoodsEditPageState extends State<GoodsEditPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _manufacturerController = TextEditingController();
  TextEditingController _pictureUrlController = TextEditingController();
  TextEditingController _versionController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _publishingHouseController = TextEditingController();
  TextEditingController _purchaseCostController = TextEditingController();
  TextEditingController _retailPriceController = TextEditingController();
  TextEditingController _inventoryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // 如果传入了商品信息，则将文本编辑控制器的文本设置为商品信息
    _nameController.text = widget.goods!.name ?? '';
    _manufacturerController.text = widget.goods!.manufacturer ?? '';
    _pictureUrlController.text = widget.goods!.pictureUrl ?? '';
    _versionController.text = widget.goods!.version ?? '';
    _descriptionController.text = widget.goods!.description ?? '';
    _publishingHouseController.text = widget.goods!.publishingHouse ?? '';
    _purchaseCostController.text = widget.goods!.purchaseCost?.toString() ?? '';
    _retailPriceController.text = widget.goods!.retailPrice?.toString() ?? '';
    _inventoryController.text = widget.goods!.inventory?.toString() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('编辑商品'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: '名称'),
              ),
              TextFormField(
                controller: _manufacturerController,
                decoration: InputDecoration(labelText: '制造商'),
              ),
              TextFormField(
                controller: _pictureUrlController,
                decoration: InputDecoration(labelText: '图片URL'),
              ),
              TextFormField(
                controller: _versionController,
                decoration: InputDecoration(labelText: '版本'),
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: '描述'),
              ),
              TextFormField(
                controller: _publishingHouseController,
                decoration: InputDecoration(labelText: '出版社'),
              ),
              TextFormField(
                controller: _purchaseCostController,
                decoration: InputDecoration(labelText: '进货成本'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _retailPriceController,
                decoration: InputDecoration(labelText: '零售价'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _inventoryController,
                decoration: InputDecoration(labelText: '库存'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      // 执行提交修改逻辑
                      // 获取编辑后的商品信息
                      widget.goods.name = _nameController.text;
                      widget.goods.manufacturer = _manufacturerController.text;
                      widget.goods.pictureUrl = _pictureUrlController.text;
                      widget.goods.version = _versionController.text;
                      widget.goods.description = _descriptionController.text;
                      widget.goods.publishingHouse = _publishingHouseController.text;
                      widget.goods.purchaseCost = int.parse(_purchaseCostController.text);
                      widget.goods.retailPrice = int.parse(_retailPriceController.text);
                      widget.goods.inventory = int.parse(_inventoryController.text);
                      // 将编辑后的商品信息传递出去
                      Future future = AdminService.updGoods(widget.goods);
                      future.then((value) {
                        setState(() {
                          Fluttertoast.showToast(msg: "注意刷新商品页面");
                        });
                      });
                    },
                    child: Text('提交修改'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Fluttertoast.showToast(msg: "注意刷新商品页面");
                      // 取消操作
                    },
                    child: Text('取消'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
