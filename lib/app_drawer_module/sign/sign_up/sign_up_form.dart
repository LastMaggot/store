import 'package:store/appPages.dart';
import 'package:store/comphonents/slide_verify_widget.dart';
import 'package:store/reference/references.dart';
import 'package:flutter/material.dart';
import 'package:store/service/customer_service.dart';
import 'package:store/style/app_style.dart';

class SignUpForm extends StatefulWidget {
  SignUpForm({Key? key}) : super(key: key);
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  TextEditingController _accountController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _mailController = TextEditingController();
  bool _showPassward = false;
  bool _canSendMailMessage = false;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _verifySuccess() {
    _canSendMailMessage = true;
  }

  void _onSignUp() {
    if(!_canSendMailMessage) {
      Fluttertoast.showToast(msg: "请先通过滑块人机验证");
    }
    String account = _accountController.text;
    String password = _passwordController.text;
    String email = _mailController.text;
    Future future = CustomerService.signUp(account, password, email);
    future.then((value) {
      if(value) {
        Navigator.pushReplacementNamed(context, '/sign_in');
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
              decoration: AppDecoration.inputDecorationFromLH(
                  labelText: "账号", hintText: "请输入账号"),
              validator: (v) {
                if (v!.isEmpty) return null;
                if (v.length < 5) return "账号长度不能小于5位";
                RegExp accountRegex = RegExp(r'^\w*$');
                if (!accountRegex.hasMatch(v)) return "账号仅能由数字,字母和_组成";
                return null;
              },
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _passwordController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: AppDecoration.inputDecorationFromLH(
                  labelText: "密码", hintText: "请输入密码"),
              obscureText: !_showPassward,
              validator: (v) {
                if (v!.isEmpty) return null;
                if (v.length < 8) return "密码长度不能小于8位";
                RegExp passwardRegex = RegExp(
                    r"^(?=.*[a-zA-Z])(?=.*[\d.+\-=_*/])[a-zA-Z\d.+\-=_*/]{8,}$");
                return (passwardRegex.hasMatch(v))
                    ? null
                    : '''
                密码必须满足如下需求:
                1.密码不能小于8位
                2.密码只能由数字,字母和特殊符号".+-=_*/"组成
                3.至少包含一个字母
                ''';
              },
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _mailController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: AppDecoration.inputDecorationFromLH(
                  labelText: "邮箱", hintText: "请输入邮箱，请确保您输入的邮箱是正确的，必要时用于邮箱登录"),
              validator: (v) {
                if (v!.isEmpty) return null;
                RegExp accountRegex = RegExp(
                    r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$');
                if (!accountRegex.hasMatch(v)) return "邮箱的格式不对！";
                return null;
              },
            ),
            SizedBox(
              height: 10,
            ),
            SlideVerifyWidget(width: width,verifySuccessListener: _verifySuccess,),
            Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Column(
                  children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints.expand(height: 55.0),
                      child: ElevatedButton(
                        onPressed: _onSignUp,
                        child: Text("注册"),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 15)),
                    ConstrainedBox(
                      constraints: const BoxConstraints.expand(height: 55.0),
                      child: ElevatedButton(
                        onPressed: () {
                          SignPageState? signPageState =
                              context.findAncestorStateOfType<SignPageState>();
                          if (signPageState == null) {
                            Fluttertoast.showToast(msg: "获取SignPage状态失败");
                          } else {
                            Fluttertoast.showToast(msg: "返回登录页面");
                            Navigator.pushReplacementNamed(context, '/sign_in');
                          }
                        },
                        child: Text("返回登录"),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
