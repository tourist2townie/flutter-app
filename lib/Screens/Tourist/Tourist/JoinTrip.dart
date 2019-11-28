import 'package:flutter/material.dart';
import 'package:tt/Screens/Tourist/Tourist/AdventureGuideList.dart';
import 'package:tt/Screens/Tourist/Tourist/Beach.dart';
import 'package:tt/Screens/Tourist/Tourist/Hike.dart';
import 'package:tt/Screens/Tourist/Tourist/HistoricalPlacesGuideList.dart';

String place;

class JoinTrip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: Center(
              child: place != null ? Text(place) : Text("All guides"),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  showSearch(context: context, delegate: GuideSearch());
                },
              )
            ],
            backgroundColor: Colors.indigo,
          ),
          body: SafeArea(
            child: Hike(),
          )
        ),
      ),
    );
  }
}

class GuideSearch extends SearchDelegate<String> {
  final places = [
    "Hanthana",
    "Pidurangala",
    "Nuckels",
    "Nilaweli",
    "Chariot path",
  ];

  final recentPlaces = [
    "Nuckels",
    "Nilaweli",
    "Chariot path",
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    //actions for app bar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //leading icon
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // show the result
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //show search something
    final suggestionList = query.isEmpty
        ? recentPlaces
        : places.where((p) => p.startsWith(query)).toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.local_airport),
          title: RichText(
            text: TextSpan(
                text: suggestionList[index].substring(0, query.length),
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                      text: suggestionList[index].substring(query.length),
                      style: TextStyle(color: Colors.grey))
                ]),
          ),
          onTap: () {
            place = suggestionList[index];
            Navigator.pop(context);
          },
        );
      },
    );
  }
}
