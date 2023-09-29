import 'package:flutter/material.dart';
import 'package:store/appPages.dart';
import 'package:store/app_bottom_modules/carts/cart_page.dart';
import 'package:store/app_drawer_module/userinfo/userinfo.dart';
import 'package:store/global/app_globals.dart';
import 'package:store/reference/references.dart';
import 'package:store/service/customer_service.dart';
import 'package:store/style/app_style.dart';
import 'package:store/pojo/app_pojo.dart';
import 'package:store/util/logs.dart';

class PageFrame extends StatefulWidget {
  Widget? body;
  PageFrame({Key? key, this.body}) : super(key: key);
  @override
  _PageFrameState createState() => _PageFrameState();
}

class _PageFrameState extends State<PageFrame> {
  int currentPageIdx = 0;
  Customer? _customer;
  String? username;
  CustomerLevel? level;
  bool? _isLogin;

  final List<Widget> pages = [HomePage(),CartPage(),OrderPage()];

  @override
  void initState() {
    currentPageIdx = 0;

    AppGlobals _appGlobals = context.read<AppGlobals>();
    SharedPreferences _cache = _appGlobals.cache;
    String token = _cache.getString('token')??"null";
    Logger.log(msg: 'token = ${token}');
    if(token.length < 20) {
      _appGlobals.clear();
      return;
    }
    
    _customer = _appGlobals.customer;
    _isLogin = _customer != null;
    if(_isLogin != null && _isLogin == true) {
      username = _customer?.username;
      level = _customer?.level;
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
              Expanded(child: Text("购物车",textAlign: TextAlign.center,))
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: (_isLogin==false)?[
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/sign');
                    },
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Text(
                        "请登入",
                        style: AppTextStyle.drawerTitleStyle,
                      ),
                    ),
                  ),
                ]:[
                  Text(
                    username??"test",
                    style: AppTextStyle.drawerTitleStyle,
                  ),
                  Text(
                    "test",
                    style: AppTextStyle.vipTextStyle,
                  )
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('主页'),
              onTap: () {
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('用户信息'),
              onTap: () {
                if(_customer != null) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CustomerEditPage(customer: _customer!)));
                }
                // Handle onTap event for Settings
              },
            ),
            ListTile(
              leading: Icon(Icons.manage_accounts_rounded),
              title: Text("管理员登录"),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/adminSign');
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("注销"),
              onTap: () {
                CustomerService.logout(context: context);
                Navigator.pushReplacementNamed(context, '/sign');
              },
            ),
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
      body: IndexedStack(
        index: currentPageIdx,
        children: pages,
      ),
    );
  }
}
