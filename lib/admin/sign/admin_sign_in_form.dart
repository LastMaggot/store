import 'package:store/appPages.dart';
import 'package:store/global/app_globals.dart';
import 'package:store/reference/references.dart';
import 'package:flutter/material.dart';
import 'package:store/service/customer_service.dart';
import 'package:store/style/app_style.dart';
import 'package:store/pojo/app_pojo.dart';

class AdminSignInForm extends StatefulWidget {

  AdminSignInForm({Key? key}) : super(key: key);
  @override
  _AdminSignInFormState createState() => _AdminSignInFormState();
}

class _AdminSignInFormState extends State<AdminSignInForm> {
  TextEditingController _accountController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _showPassward = false;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _onSignIn() {

    // todo Test
    Navigator.pushNamed(context, '/admin');

    // String account = _accountController.text;
    // String password = _passwordController.text;
    // Future<Customer?> future = CustomerService.signIn(account, password,context: context);
    // future.then((value) {
    //   if(value == null) {
    //     return;
    //   }
    //   Navigator.pushReplacementNamed(context, '/admin');
    // });
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
                ],
              )
          ),
        ],
      ),
    ),
    );
  }
}
