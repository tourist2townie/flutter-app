import 'package:fancy_bottom_bar/fancy_bottom_bar.dart';
import 'package:fancy_bottom_bar/fancy_bottom_item.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tt/Screens/Tourist/Tourist/OngoingTripCell.dart';
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
    FancyBottomItem(
        title: Text(
          "Trips",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red,fontSize: 20),
        ),
        icon: Icon(
          MdiIcons.hiking,
          color: Colors.red,
        )),
    FancyBottomItem(
        title: Text(
          "Timeline",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
        ),
         icon: Icon(
          MdiIcons.googlePhotos,
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
                    child:OngoingTripCell(),
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
