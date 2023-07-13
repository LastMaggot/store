import 'package:flutter/material.dart';
import 'package:store/appPages.dart';
import 'package:store/comphonents/AppPageFrame.dart';
import 'package:store/comphonents/slide_verify_widget.dart';
import 'package:store/global/app_globals.dart';
import 'package:store/reference/references.dart';
import 'package:store/sign/sign_in/sign_in_form.dart';
import 'package:store/sign/sign_up/sign_up_form.dart';

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
    return MaterialApp(
      builder: FToastBuilder(),
      themeMode: ThemeMode.light,
      onGenerateRoute: (RouteSettings settings) {
        String? name = settings.name;
        switch (name) {
          case "/home":
            return MaterialPageRoute(builder: (context) => HomePage());
          case "/sign":
            return MaterialPageRoute(builder: (context) => SignPage());
          case "/sign_in":
            return MaterialPageRoute(builder: (context) => SignPage(body: SignInForm(),));
          case "/sign_up":
            return MaterialPageRoute(builder: (context) => SignPage(body: SignUpForm(),));
          case "/user":
            return MaterialPageRoute(builder: (context) => UserPage());
          case "/admin":
            return MaterialPageRoute(builder: (context) => AdminPage());
          case "/order":
            return MaterialPageRoute(builder: (context) => OrderPage());
          case "/shopping":
            return MaterialPageRoute(builder: (context) => ShoppingPage());
          default:
            return MaterialPageRoute(builder: (context) => HomePage());
        }
      },
      title: '蓝天购物平台',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: PageFrame(body: HomePage(),),
    );
  }
}
