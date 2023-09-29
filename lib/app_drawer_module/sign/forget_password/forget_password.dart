import 'package:store/appPages.dart';
import 'package:store/global/app_globals.dart';
import 'package:store/reference/references.dart';
import 'package:flutter/material.dart';
import 'package:store/service/customer_service.dart';
import 'package:store/style/app_style.dart';
import 'package:store/pojo/app_pojo.dart';

class ForgetPasswordForm extends StatefulWidget {

  ForgetPasswordForm({Key? key}) : super(key: key);
  @override
  _ForgetPasswordFormState createState() => _ForgetPasswordFormState();
}

class _ForgetPasswordFormState extends State<ForgetPasswordForm> {
  TextEditingController _accountController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _onSend() {
    String account = _accountController.text;
    String email = _emailController.text;
    Future<bool> future = CustomerService.forgetPassword(account, email);
    future.then((value) {
      if(value == null) {
        return;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    return Container(
      width: width,
      height: height,
      child: Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextFormField(
            controller: _accountController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: AppDecoration.inputDecorationFromLH(labelText: "账号",hintText: "请输入账号"),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: _emailController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: AppDecoration.inputDecorationFromLH(labelText: "邮箱",hintText: "请输入邮箱"),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints.expand(height: 55.0),
                    child: ElevatedButton(
                      onPressed: _onSend,
                      child: Text("发送邮件"),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 15)),
                  ConstrainedBox(
                    constraints: const BoxConstraints.expand(height: 55.0),
                    child: ElevatedButton(
                      onPressed: () {
                        SignPageState? signPageState = context.findAncestorStateOfType<SignPageState>();
                        if(signPageState == null) {
                          Fluttertoast.showToast(msg: "获取SignPage状态失败");
                        }
                        else {
                          Fluttertoast.showToast(msg: "返回登入界面");
                          Navigator.pushReplacementNamed(context, '/sign_in');
                        }
                      },
                      child: Text("返回登入"),
                    ),
                  ),
                ],
              )
          ),
        ],
      ),
    ),
    );
  }
}
