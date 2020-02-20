import 'package:flutter/material.dart';
import 'package:tt/Screens/Tourist/Tourist/AllGuides.dart';
import 'package:tt/Screens/Tourist/Tourist/Packages.dart';
import 'package:tt/utils/ResponseData.dart';

import 'SearchResult.dart';

String place;

class JoinTrip extends StatefulWidget {
  @override
  _JoinTripState createState() => _JoinTripState();
}

class _JoinTripState extends State<JoinTrip> with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: DefaultTabController(
      length: 2,
      child: Scaffold(
          bottomNavigationBar: Material(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              indicatorColor: Colors.indigo,
              labelColor: Colors.indigo,
              unselectedLabelColor: Colors.grey,
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.all_inclusive),
                  text: "All guides",
                ),
                Tab(
                  icon: Icon(Icons.list),
                  child: Text('Packages'),
                )
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: <Widget>[
              AllGuides(),
              Packages(),
            ],
          )),
    ));
  }
}

class GuideSearch extends SearchDelegate<String> {
  final places = [
    "Hanthana",
    "Pidurangala",
    "Nuckels",
    "Nilaweli",
    "Chariot path",
    "Ella",
    "Weligama",
    'Katusukonda',
    'Upper diyaluma',
    'Adams peak'
    'weligama'
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
    ResponseData.searchQuery = query;
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
            ResponseData.searchQuery = suggestionList[index];
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SearchResult()));
          },
        );
      },
    );
  }
}
