import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:store/comphonents/overlay_window.dart';
import 'package:store/pojo/app_pojo.dart';
import 'package:store/service/admin_service.dart';

class CustomerTable extends StatefulWidget {
  const CustomerTable({super.key});

  @override
  _CustomerTableState createState() => _CustomerTableState();
}

class _CustomerTableState extends State<CustomerTable> {
  String _selectedOption = 'id';
  TextEditingController _searchController = TextEditingController();

  List<Customer> customerList = [];
  List<DataRow> customerDataRows = [];

  void makeDataRows() {
    int idx = 0;
    for (Customer customer in customerList) {
      customerDataRows.add(
        DataRow(cells: [
          DataCell(Text(customer.id.toString())),
          DataCell(Text(customer.account!)),
          DataCell(Text(customer.username!)),
          DataCell(Text(customer.level.toString())),
          DataCell(Text(customer.registrationDate.toString())),
          DataCell(Text(customer.totalSpent.toString())),
          DataCell(Text(customer.email!)),
          DataCell(Row(
            children: [
              InkWell(
                onTap: () {
                  Future future = AdminService.resetPassword(customer.account!);
                  future.then((value) {
                    setState(() {

                    });
                  });
                },
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('重置密码'),
                ),
              ),
              InkWell(
                onTap: () {
                  OverlayWindow overlay = OverlayWindow();
                  overlay.showConfirmationAlertDialog(context, title: '删除用户', content: "确定要删除用户吗？",buttonMsg: "确定删除",buttonFunction: () {
                    Future future = AdminService.deleteCustomerById(customer.id!);
                    future.then((value) {
                      customerDataRows.removeAt(idx);
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
      future = AdminService.getCustomerInfoById(id);
    }
    else {
      future = AdminService.getCustomerInfoByName(text);
    }
    future.then((value) {
      this.customerList = value;
      if(customerList == null) {
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
                  items: <String>['id', '姓名'].map((String value) {
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
                    customerDataRows = [];
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
                DataColumn(label: Text('账号')),
                DataColumn(label: Text('用户名')),
                DataColumn(label: Text('级别')),
                DataColumn(label: Text('注册日期')),
                DataColumn(label: Text('消费总额')),
                DataColumn(label: Text('邮箱')),
                DataColumn(label: Text('操作')),
              ],
              rows: customerDataRows,
            ),
          ),
        ),
      ],
    );
  }
}
