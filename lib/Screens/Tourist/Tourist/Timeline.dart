import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:tt/Screens/Tourist/Tourist/Addplace.dart';

String apiurl = "http://10.0.2.2:8000/api/retrieveTimeline/";

List data;

class Timeline extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TimelineState();
  }
}

class TimelineState extends State<Timeline> {
  @override
  void initState() {
    super.initState();
    this.getTimelineData(context);
  }

  void getTimelineData(BuildContext context) async {
    var response = await http
        .get(Uri.encodeFull(apiurl), headers: {"Accept": "application/json"});

    setState(() {
      var convertJsonToData = json.decode(response.body);
      data = convertJsonToData;
      print(data[0]['image']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.teal,
          isExtended: true,
          icon: Icon(Icons.add),
          label: Text("Add"),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddPlace()));
          },
        ),
        appBar: AppBar(
          title: Text("Timeline"),
          backgroundColor: Colors.teal,
        ),
        body: Container(
          decoration:
              BoxDecoration(color: Colors.orangeAccent.withOpacity(0.3)),
          child: ListView.builder(
              itemCount: data.length == null ? 0 : data.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(4.0),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                ListTile(
                                  leading: Text(
                                    data[index]['place'],
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  trailing: Text(
                                    data[index]['date'],
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  child: Image(
                                      image: AssetImage(
                                          "assets/images/chariot_path.jpg")),
                                ),
                                ListTile(
                                  leading: IconButton(
                                    icon: Icon(
                                      Icons.favorite,
                                    ),
                                    onPressed: () {},
                                    color: Colors.teal,
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                    ),
                                    onPressed: () {},
                                    color: Colors.teal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ));
  }
}
