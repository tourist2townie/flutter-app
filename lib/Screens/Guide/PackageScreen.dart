import 'dart:convert';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tt/Chatroom/Chatroom.dart';
import 'package:tt/Screens/Guide/NewPackages.dart';
import 'package:tt/Screens/Guide/TouristProfileGuide.dart';
import 'package:tt/utils/ResponseData.dart';

class PackagesScreen extends StatefulWidget {
  @override
  _PackagesScreenState createState() => _PackagesScreenState();
}

class _PackagesScreenState extends State<PackagesScreen> {
  String apiurl =
      "http://10.0.2.2:8000/api/getPackagesForGuide/${ResponseData.userId}";
  List data;

  void getSubscribedPackages(BuildContext context) async {
    var response = await http
        .get(Uri.encodeFull(apiurl), headers: {"Accept": "application/json"});

    if (this.mounted) {
      setState(() {
        var convertJsonToData = json.decode(response.body);
        data = convertJsonToData;
      });
    }
  }

  @override
  void initState() {
    this.getSubscribedPackages(context);
    print(apiurl);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _fab(),
      body: _packagesList(),
    );
  }

  Widget _fab() {
    return FloatingActionButton.extended(
      label: Text("New packages"),
      icon: Icon(Icons.fiber_new),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => NewPackages()));
      },
      backgroundColor: Colors.indigo,
    );
  }

  Widget _packagesList() {
    return data != null && data.length != null && data.length > 0
        ? ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return ExpandableNotifier(
                  child: ScrollOnExpand(
                scrollOnExpand: false,
                scrollOnCollapse: true,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 150,
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/pidurangala.jpg"),
                                  fit: BoxFit.cover),
                              shape: BoxShape.rectangle,
                            ),
                          ),
                        ),
                        ScrollOnExpand(
                          scrollOnExpand: true,
                          scrollOnCollapse: false,
                          child: ExpandablePanel(
                            tapHeaderToExpand: true,
                            tapBodyToCollapse: true,
                            headerAlignment:
                                ExpandablePanelHeaderAlignment.center,
                            header: Padding(
                              padding: EdgeInsets.all(10),
                              child: ListTile(
                                  title: Text(
                                data[index]['category'],
                                style: Theme.of(context).textTheme.body2,
                              )),
                            ),
                            collapsed: RaisedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Chatroom()));
                              },
                              child: Text("Chartoom"),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                              color: Colors.teal,
                            ),
                            expanded: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  child: Column(
                                    children: <Widget>[
                                      InkWell(
                                        onTap: () {
                                          ResponseData.searchedTourist =
                                              data[index]['tourist_id']
                                                  .toString();
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      TouristProfileGuide()));
                                        },
                                        child: Card(
                                          child: ListTile(
                                            leading: Text("Name of customer"),
                                            trailing: Text(data[index]
                                                    ['tourist_id']
                                                .toString()),
                                          ),
                                        ),
                                      ),
                                      Card(
                                        child: ListTile(
                                          leading: Text("Date"),
                                          trailing: Text(data[index]['date']),
                                        ),
                                      ),
                                      Card(
                                        child: ListTile(
                                          leading: Text("No of days"),
                                          trailing: Text(data[index]['province']
                                              .toString()),
                                        ),
                                      ),
                                      RaisedButton(
                                        onPressed: () {},
                                        child: Text("Confirm Request"),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0)),
                                        color: Colors.teal,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            builder: (_, collapsed, expanded) {
                              return Padding(
                                padding: EdgeInsets.only(
                                    left: 10, right: 10, bottom: 10),
                                child: Expandable(
                                  collapsed: collapsed,
                                  expanded: expanded,
                                  crossFadePoint: 0,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ));
            },
          )
        : Container(
            child: Center(
              child: Text(
                "You have no packages yet",
                style: TextStyle(
                    color: Colors.indigo,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          );
  }
}
