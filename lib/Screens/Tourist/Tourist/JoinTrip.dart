import 'package:flutter/material.dart';
import 'package:tt/Screens/Tourist/Tourist/AdventureGuideList.dart';
import 'package:tt/Screens/Tourist/Tourist/Beach.dart';
import 'package:tt/Screens/Tourist/Tourist/Hike.dart';
import 'package:tt/Screens/Tourist/Tourist/HistoricalPlacesGuideList.dart';

class JoinTrip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.teal,
            bottom: TabBar(
              unselectedLabelColor: Colors.red,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0), color: Colors.red),
              tabs: <Widget>[
                Tab(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        border: Border.all(
                          color: Colors.red,
                          width: 1,
                        )),
                    child: Align(
                      child: Text("Hike"),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        border: Border.all(
                          color: Colors.red,
                          width: 1,
                        )),
                    child: Align(
                      child: Text("Adventure"),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        border: Border.all(
                          color: Colors.red,
                          width: 1,
                        )),
                    child: Align(
                      child: Text("Historical"),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        border: Border.all(
                          color: Colors.red,
                          width: 1,
                        )),
                    child: Align(
                      child: Text("Beaches"),
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              Hike(),
              Adventure(),
              HistoricalPlaces(),
              Beach()
            ],
          ),
        ),
      ),
    );
  }
}
