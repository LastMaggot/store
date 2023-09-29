import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:store/service/admin_service.dart';

class PasswordChangePage extends StatelessWidget {
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    return Scaffold(
      body: Container(
        width: width*0.6,
        height: height,
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _accountController,
                decoration: InputDecoration(labelText: '账号'),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _newPasswordController,
                decoration: InputDecoration(labelText: '新密码'),
                obscureText: true, // 隐藏密码
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  // 执行提交修改逻辑
                  String account = _accountController.text;
                  String newPassword = _newPasswordController.text;
                  // 在这里处理账号和新密码的提交逻辑
                  Future future = AdminService.resetAdminPassword(account, newPassword);
                  future.then((value) {
                    Fluttertoast.showToast(msg: "成功修改");
                  });
                },
                child: Text('提交修改'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: PasswordChangePage()));
