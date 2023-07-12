
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store/style/appStyle.dart';

@immutable
class AppTitleBar extends StatefulWidget{

  @override
  _AppTitleBarState createState() => _AppTitleBarState();
}

class _AppTitleBarState extends State<AppTitleBar> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}