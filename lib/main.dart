import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:store/admin/goods/goods_search.dart';
import 'package:store/admin/sign/admin_sign.dart';
import 'package:store/admin/sign/admin_sign_in_form.dart';
import 'package:store/appPages.dart';
import 'package:store/app_bottom_modules/carts/cart_page.dart';
import 'package:store/app_drawer_module/sign/forget_password/forget_password.dart';
import 'package:store/app_drawer_module/sign/sign_in/sign_in_form.dart';
import 'package:store/app_drawer_module/sign/sign_up/sign_up_form.dart';
import 'package:store/comphonents/AppPageFrame.dart';
import 'package:store/global/app_globals.dart';
import 'package:store/pojo/app_pojo.dart';
import 'package:store/reference/references.dart';
import 'package:store/service/customer_service.dart';
import 'package:store/util/logs.dart';

void main() async {
  SharedPreferences cache = await SharedPreferences.getInstance();
  runApp(ChangeNotifierProvider<AppGlobals>(
    create: (BuildContext context) => AppGlobals(cache: cache),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppGlobals appGlobals = context.read<AppGlobals>();
    return MaterialApp(
      builder: FToastBuilder(),
      themeMode: ThemeMode.light,
      onGenerateRoute: (RouteSettings settings) {
        String? name = settings.name;
        switch (name) {
          case "/home":
            return MaterialPageRoute(builder: (context) => PageFrame(body: HomePage(),));
          case "/cart":
            return MaterialPageRoute(builder: (context) => PageFrame(body: CartPage(),));
          case "/sign":
            return MaterialPageRoute(builder: (context) => SignPage(),);
          case "/sign_in":
            return MaterialPageRoute(builder: (context) => SignPage(body: SignInForm(),));
          case "/sign_up":
            return MaterialPageRoute(builder: (context) => SignPage(body: SignUpForm(),));
          case "/forget_password":
            return MaterialPageRoute(builder: (context) => SignPage(body: ForgetPasswordForm(),));
          case "/admin":
            return MaterialPageRoute(builder: (context) => AdminPage());
          case "/adminSign":
            return MaterialPageRoute(builder: (context) => AdminSignPage(body: AdminSignInForm(),));
          case "/order":
            return MaterialPageRoute(builder: (context) => PageFrame(body: OrderPage(),));
          case "/shopping":
            return MaterialPageRoute(builder: (context) => PageFrame(body: ShoppingPage(),));
          default:
            return MaterialPageRoute(builder: (context) => PageFrame(body: HomePage(),));
        }
      },
      title: '蓝天购物平台',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      // home: AdminPage(),
      // home: PageFrame(body: HomePage(),),
      home: FutureBuilder<bool>(
        future: CustomerService.loginByToken(appGlobals.token!, context: context),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          else if(snapshot.hasError || snapshot.data.isNull) {
            Logger.error(msg: snapshot.stackTrace.toString());
            Fluttertoast.showToast(msg: "使用token登录失败");
            return AdminSignPage(body: AdminSignInForm(),);
          }
          else if(snapshot.hasData) {
            bool status = snapshot.data!;
            if(status == true) {
              return PageFrame(body: HomePage(),);
            }
          }
          return AdminSignPage(body: AdminSignInForm(),);
        },
      ),
    );
  }
}
