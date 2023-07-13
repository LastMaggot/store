import 'package:store/appPages.dart';
import 'package:store/reference/references.dart';
import 'package:flutter/material.dart';
import 'package:store/style/app_style.dart';

class SignInForm extends StatefulWidget {

  SignInForm({Key? key}) : super(key: key);
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  TextEditingController _accountController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _showPassward = false;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _onSignIn() {

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
            controller: _passwordController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: AppDecoration.inputDecorationFromLH(labelText: "密码",hintText: "请输入密码"),
            obscureText: !_showPassward,
          ),
          Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints.expand(height: 55.0),
                    child: ElevatedButton(
                      onPressed: _onSignIn,
                      child: Text("登录"),
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
                          Fluttertoast.showToast(msg: "进入注册页面");
                          Navigator.pushReplacementNamed(context, '/sign_up');
                        }
                      },
                      child: Text("注册"),
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
