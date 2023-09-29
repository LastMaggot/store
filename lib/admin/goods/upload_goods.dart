import 'package:flutter/material.dart';
import 'package:store/pojo/app_pojo.dart';
import 'package:store/service/admin_service.dart';

class UploadGoodsFormPage extends StatefulWidget {
  @override
  _UploadGoodsFormPageState createState() => _UploadGoodsFormPageState();
}

class _UploadGoodsFormPageState extends State<UploadGoodsFormPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _manufacturerController = TextEditingController();
  TextEditingController _pictureUrlController = TextEditingController();
  TextEditingController _versionController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _publishingHouseController = TextEditingController();
  TextEditingController _purchaseCostController = TextEditingController();
  TextEditingController _retailPriceController = TextEditingController();



  String? validateNull(String? value) {
    // 如果输入为空，返回错误提示
    if(value == null) return null;
    if (value.isEmpty) {
      return '不能为空';
    }
    // 输入合法，返回null
    return null;
  }

  String? validateNumber(String? value) {
    // 如果输入为空，返回错误提示
    if(value == null) return null;
    if (value.isEmpty) {
      return '请输入数字';
    }
    // 使用正则表达式判断输入是否为数字
    final RegExp regex = RegExp(r'^[0-9]+$');
    if (!regex.hasMatch(value)) {
      return '请输入有效的数字';
    }
    // 输入合法，返回null
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('提交商品'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: '名称'),
                  validator: validateNull,
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
                  decoration: InputDecoration(labelText: '店名'),
                  validator: validateNull,
                ),
                TextFormField(
                  controller: _purchaseCostController,
                  decoration: InputDecoration(labelText: '进货成本'),
                  keyboardType: TextInputType.number,
                  validator: validateNumber,
                ),
                TextFormField(
                  controller: _retailPriceController,
                  decoration: InputDecoration(labelText: '零售价'),
                  keyboardType: TextInputType.number,
                  validator: validateNumber,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    FormState? formState = _formKey.currentState;
                    if(formState == null) return;
                    if (_formKey.currentState!.validate()) {
                      // 执行提交逻辑
                      // 获取表单中的各个属性的值
                      String name = _nameController.text;
                      String manufacturer = _manufacturerController.text;
                      String pictureUrl = _pictureUrlController.text;
                      String version = _versionController.text;
                      String description = _descriptionController.text;
                      String publishingHouse = _publishingHouseController.text;
                      int purchaseCost = int.parse(_purchaseCostController.text);
                      int retailPrice = int.parse(_retailPriceController.text);
                      // 在这里使用这些值执行提交操作
                      Goods goods = Goods(0, name, manufacturer, pictureUrl, version, description, publishingHouse, purchaseCost, retailPrice);
                      Future future = AdminService.addGoods(goods);

                    }
                  },
                  child: Text('提交'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: UploadGoodsFormPage()));
