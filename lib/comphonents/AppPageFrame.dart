import 'package:flutter/material.dart';
import 'package:store/appPages.dart';
import 'package:store/global/app_globals.dart';
import 'package:store/reference/references.dart';
import 'package:store/style/app_style.dart';

class PageFrame extends StatefulWidget {
  Widget? body;
  PageFrame({Key? key, this.body}) : super(key: key);
  @override
  _PageFrameState createState() => _PageFrameState();
}

class _PageFrameState extends State<PageFrame> {
  int currentPageIdx = 0;
  bool? _isLogin;
  String? userName;
  String? vipLevel;

  void showHome() {
    widget.body = HomePage();
    setState(() {

    });
  }

  void showCart() {

  }

  void showUser() {
    widget.body = UserPage();
  }

  @override
  void initState() {
    currentPageIdx = 0;
    SharedPreferences cache = context.read<AppGlobals>().cache;
    _isLogin = cache.getBool('isLogin');
    if(_isLogin == null) {
      _isLogin = false;
      userName = cache.getString('userName');
      vipLevel = cache.getString('vipLevel');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                showHome();
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('UserInfo'),
              onTap: () {
                // Handle onTap event for Settings
              },
            ),
            ListTile(
              leading: Icon(Icons.manage_accounts_rounded),
              title: Text("管理员登录"),
              onTap: () {},
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPageIdx,
        iconSize: 24,
        onTap: (index) {
          currentPageIdx = index;
          setState(() {});
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            tooltip: "主页",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_rounded),
            label: 'Cart',
            tooltip: "购物车",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.airplane_ticket),
            label: "Order",
            tooltip: "订单",
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: 200,
                color: Colors.white,
                child: Center(
                  child: Text('Bottom Sheet Content'),
                ),
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
      body: widget.body,
    );
  }
}
