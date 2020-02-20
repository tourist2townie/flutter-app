
import 'package:flutter/material.dart';
import 'package:tt/Screens/Tourist/Tourist/packages/AdventurePackages.dart';
import 'package:tt/Screens/Tourist/Tourist/packages/BeachesPackage.dart';
import 'package:tt/Screens/Tourist/Tourist/packages/HikePackages.dart';
import 'package:tt/Screens/Tourist/Tourist/packages/HistoricalPackage.dart';

String category, guidename, date, province, type;
int days;
List data;

class Packages extends StatefulWidget {
  @override
  _PackagesState createState() => _PackagesState();
}

class _PackagesState extends State<Packages> with TickerProviderStateMixin {
  TabController _nestedTabController;
  @override
  void initState() {
    _nestedTabController = new TabController(length: 4, vsync: this);
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
    return Column(
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
              text: "Hike",
            ),
            Tab(
              text: "Adventure",
            ),
            Tab(
              text: "Beaches",
            ),
            Tab(
              text: "Historical",
            ),
          ],
        ),
        Container(
          height: screenHeight * 0.70,
          margin: EdgeInsets.only(left: 16.0, right: 16.0),
          child: TabBarView(
            controller: _nestedTabController,
            children: <Widget>[
              HikePackages(),
              AdventurePackage(),
              BeachesPackage(),
              HistoricalPackage(),
            ],
          ),
        )
      ],
    );
  }
}
