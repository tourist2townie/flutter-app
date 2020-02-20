import 'package:flutter/material.dart';
import 'package:tt/Screens/Admin/AllGuides.dart';
import 'package:tt/Screens/Admin/AllTourists.dart';
import 'package:tt/Screens/Admin/Drawer.dart';
import 'package:tt/utils/ResponseData.dart';

class MainScreenAdmin extends StatefulWidget {
  @override
  _MainScreenAdminState createState() => _MainScreenAdminState();
}

class _MainScreenAdminState extends State<MainScreenAdmin> with TickerProviderStateMixin {
  TabController _nestedTabController;

  @override
  void initState() {
    _nestedTabController = new TabController(length: 2, vsync: this);
    super.initState();
  }

   @override
  void dispose() {
    super.dispose();
    _nestedTabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("All users"),
        backgroundColor: Colors.indigo,
      ),
      drawer: AdminDrawer(),
      drawerScrimColor: Colors.indigo.withOpacity(0.6),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          TabBar(
          controller: _nestedTabController,
          indicatorColor: Colors.indigo,
          labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          labelColor: Colors.indigo,
          unselectedLabelColor: Colors.black54,
          isScrollable: true,
          tabs: <Widget>[
            Tab(
              text: ResponseData.noOfGuides !=null? "All guides ":"All guides",
            ),
            Tab(
              text: ResponseData.noOfGuides !=null? "All tourists ":"All tourists",
            ),
          ],
        ),
         Container(
          height: screenHeight * 0.80,
          margin: EdgeInsets.only(left: 16.0, right: 16.0),
          child: TabBarView(
            controller: _nestedTabController,
            children: <Widget>[
              ViewAllGuides(),
              ViewAllTourists(),
            ],
          ),
        )
        ],
      ),
    );
  }
}