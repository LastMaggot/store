
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store/reference/references.dart';
import 'package:store/style/appStyle.dart';

class PageFrame extends StatefulWidget{
  final Widget? body;
  PageFrame({Key? key,this.body}) : super(key: key);
  @override
  _PageFrameState createState() => _PageFrameState();
}

class _PageFrameState extends State<PageFrame> {

  int currentPageIdx = 0;

  @override
  void initState() {
    currentPageIdx = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Fluttertoast.showToast(msg: "测试Toast",timeInSecForIosWeb: 5);
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPageIdx,
        iconSize: 24,
        onTap: (index) {

          currentPageIdx = index;
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            tooltip: "主页",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
            tooltip: "设置页",
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