import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fancy_bottom_bar/fancy_bottom_bar.dart';
import 'package:fancy_bottom_bar/fancy_bottom_item.dart';
import 'package:flutter/material.dart';
import 'package:tt/Screens/Guide/ConfirmRequest.dart';
import 'package:tt/Screens/Guide/PackageScreen.dart';

import 'OngoingTrip.dart';

class GuideMainScreen extends StatefulWidget {
  @override
  _GuideMainScreenState createState() => _GuideMainScreenState();
}

class _GuideMainScreenState extends State<GuideMainScreen> {
  @override
  void initState() {
    super.initState();
  }

  final tabItems = [
    FancyBottomItem(
        title: Text(
          "Ongoing Trips",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
        ),
        icon: Icon(
          Icons.home,
          color: Colors.red,
        )),
    FancyBottomItem(
        title: Text(
          "Requested Trips",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
        ),
        icon: Icon(
          EvaIcons.shield,
          color: Colors.red,
        )),
    FancyBottomItem(
        title: Text(
          "Trip Packages",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
        ),
        icon: Icon(
          EvaIcons.compass,
          color: Colors.red,
        )),
  ];

  int selectedPos = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: FancyBottomBar(
          onItemSelected: (i) => setState(() => selectedPos = i),
          items: tabItems,
          selectedPosition: selectedPos,
          selectedColor: Colors.amber,
          indicatorColor: Colors.deepPurple,
        ),
        body: Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              selectedPos == 0
                  ? Expanded(
                      child: OngoingTripsGuide(),
                    )
                  : selectedPos == 1
                      ? Expanded(
                          flex: 1,
                          child: ConfirmRequest(),
                        )
                      : Expanded(
                          flex: 1,
                          child: PackagesScreen(),
                        )
            ],
          ),
        ));
  }
}
