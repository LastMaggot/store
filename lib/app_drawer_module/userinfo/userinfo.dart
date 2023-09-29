import 'package:flutter/material.dart';
import 'package:store/service/admin_service.dart'; // 导入需要的服务文件
import 'package:store/pojo/app_pojo.dart'; // 导入需要的数据模型文件

class CustomerEditPage extends StatefulWidget {
  final Customer customer;

  CustomerEditPage({Key? key, required this.customer}) : super(key: key);

  @override
  _CustomerEditPageState createState() => _CustomerEditPageState();
}

class _CustomerEditPageState extends State<CustomerEditPage> {
  TextEditingController _accountController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // 如果传入了客户信息，则将文本编辑控制器的文本设置为客户信息
    _accountController.text = widget.customer.account ?? '';
    _passwordController.text = widget.customer.password ?? '';
    _usernameController.text = widget.customer.username ?? '';
    _addressController.text = widget.customer.address ?? '';
    _phoneNumberController.text = widget.customer.phoneNumber ?? '';
    _emailController.text = widget.customer.email ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('编辑客户'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _accountController,
                decoration: InputDecoration(labelText: '账号'),
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: '密码'),
                obscureText: true, // 隐藏密码
              ),
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: '用户名'),
              ),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(labelText: '地址'),
              ),
              TextFormField(
                controller: _phoneNumberController,
                decoration: InputDecoration(labelText: '电话号码'),
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: '邮箱'),
              ),
              SizedBox(height: 20),
              Text('总消费: ${widget.customer.totalSpent ?? 0}'), // 显示totalSpent属性
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      // 执行提交修改逻辑
                      // 获取编辑后的客户信息
                      widget.customer.account = _accountController.text;
                      widget.customer.password = _passwordController.text;
                      widget.customer.username = _usernameController.text;
                      widget.customer.address = _addressController.text;
                      widget.customer.phoneNumber = _phoneNumberController.text;
                      widget.customer.email = _emailController.text;

                      // 将编辑后的客户信息传递出去
                      // Future future = AdminService.updateCustomer(widget.customer);
                      // future.then((value) {
                      //   setState(() {
                      //     // 根据服务返回的结果执行相应的操作
                      //   });
                      // });
                      setState(() {

                      });
                    },
                    child: Text('提交修改'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
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
