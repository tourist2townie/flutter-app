import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fancy_bottom_bar/fancy_bottom_bar.dart';
import 'package:fancy_bottom_bar/fancy_bottom_item.dart';
import 'package:flutter/material.dart';
import 'package:tt/Screens/Tourist/Tourist/OngoingTripCell.dart';
import 'package:tt/Screens/Tourist/Tourist/RequestedTrips.dart';

import 'Screens/Tourist/Tourist/Timeline.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
  }

  final tabItems = [
    FancyBottomItem(title: Text("Ongoing Trips",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),), icon: Icon(Icons.home,color: Colors.red,)),
    FancyBottomItem(
        title: Text("Requested Trips",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),), icon: Icon(EvaIcons.shield,color: Colors.red,)),
    FancyBottomItem(title: Text("Timeline",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),), icon: Icon(EvaIcons.tv,color: Colors.red,)),
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
                    child: OngoingTripCell(),
                  )
                : selectedPos == 1
                    ? Expanded(
                        flex: 1,
                        child: RequestedTripsCells(),
                      )
                    : Expanded(
                        flex: 1,
                        child: Timeline(),
                      ),
          ],
        ),
      ),
    );
  }
}
