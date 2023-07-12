import 'package:flutter/material.dart';
import 'package:store/appPages.dart';
import 'package:store/comphonents/AppPageFrame.dart';
import 'package:store/global/app_globals.dart';
import 'package:store/style/AppTextStyle.dart';
import 'package:store/reference/references.dart';
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
    return MaterialApp(
      builder: FToastBuilder(),
      onGenerateRoute: (RouteSettings settings) {
        String? name = settings.name;
        switch (name) {
          case "/home":
            return MaterialPageRoute(builder: (context) => HomePage());
          case "/sign":
            return MaterialPageRoute(builder: (context) => SignPage());
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
      home: PageFrame(),
    );
  }
}
