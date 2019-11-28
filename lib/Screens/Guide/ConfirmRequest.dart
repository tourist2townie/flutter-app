import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/rendering.dart';
import 'package:tt/Chatroom/Chatroom.dart';
import 'package:tt/Widgets/MyClipper.dart';
import 'package:tt/utils/ResponseData.dart';
import 'package:http/http.dart' as http;

String apiUrl = "http://10.0.2.2:8000/api/tripRequests/${ResponseData.userId}";

List data;

class ConfirmRequest extends StatefulWidget {
  @override
  State createState() {
    return ConfirmRequestState();
  }
}

class ConfirmRequestState extends State<ConfirmRequest> {
  @override
  void initState() {
    this.getTripRequests(context);
    super.initState();
  }

  void getTripRequests(BuildContext context) async {
    var response = await http
        .get(Uri.encodeFull(apiUrl), headers: {"Accept": "application/json"});

    if (this.mounted) {
      setState(() {
        var convertJsonToData = json.decode(response.body);
        data = convertJsonToData;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Container(
            child: ListView(
      children: <Widget>[
        ClipPath(
          clipper: MyClipper(),
          child: Container(
            height: 320,
            decoration: BoxDecoration(color: Colors.indigo),
            child: Center(
              child: Text(
                "Requested Trips",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 40),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
        ),
        card1()
      ],
    ))
    );
  }

  Widget card1() {
    return data != null && data.length != null && data.length > 0
        ? ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
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
                                data[index]['place'],
                                style: Theme.of(context).textTheme.body2,
                              )),
                            ),
                            collapsed: RaisedButton(
                              onPressed: () {
                                Navigator.push(context,MaterialPageRoute(
                                  builder: (context)=>Chatroom()
                                ));
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
                                      Card(
                                        child: ListTile(
                                          leading: Text("Name of customer"),
                                          trailing: Text(data[index]['tourist_id'].toString()),
                                        ),
                                      ),
                                      Card(
                                        child: ListTile(
                                          leading: Text("'Date"),
                                          trailing: Text(data[index]['date']),
                                        ),
                                      ),
                                      Card(
                                        child: ListTile(
                                          leading: Text("No of days"),
                                          trailing: Text(data[index]['No_of_days'].toString()),
                                        ),
                                      ),
                                      Center(
                                        child: RaisedButton(
                                          onPressed: () {},
                                          child: Text("Confirm Request"),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0)),
                                          color: Colors.teal,
                                        ),
                                      )
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
              child: CircularProgressIndicator(),
            ),
          );
  }
}
