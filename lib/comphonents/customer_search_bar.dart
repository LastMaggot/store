import 'package:flutter/material.dart';

class CustomerSearchBar extends StatefulWidget {
  const CustomerSearchBar({super.key});

  @override
  _CustomerSearchBarState createState() => _CustomerSearchBarState();
}

class _CustomerSearchBarState extends State<CustomerSearchBar> {
  String _selectedOption = 'id';
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width*0.7,
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
                // 在这里使用selectedOption和searchText执行搜索操作
              },
            ),
          ],
        ),
      ),
    );
  }
}
