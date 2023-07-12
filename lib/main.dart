import 'package:flutter/material.dart';
import 'package:store/appPages.dart';
import 'package:store/style/AppTextStyle.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home: Scaffold(
        key: GlobalKey<ScaffoldState>(),
        appBar: AppBar(
          leading: Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                ScaffoldState scaffoldState = Scaffold.of(context);
                if (!scaffoldState.isDrawerOpen) {
                  scaffoldState.openDrawer();
                } else {
                  scaffoldState.closeDrawer();
                }
              },
            ),
          ),
          title: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const FlutterLogo(
                  size: 35,
                ),
                const Text("蓝天购物平台"),
              ],
            ),
          ),
        ),
        drawer: Drawer(
          backgroundColor: Colors.black12,
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.lightBlueAccent,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "欢迎级别用户",
                      style: AppTextStyle.drawerTitleStyle,
                    ),
                    Text(
                      "白金VIP",
                      style: AppTextStyle.vipTextStyle,
                    )
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
                onTap: () {
                  // Handle onTap event for Home
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                onTap: () {
                  // Handle onTap event for Settings
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
