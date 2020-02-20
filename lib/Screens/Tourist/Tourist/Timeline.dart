import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:tt/Screens/Tourist/Tourist/Addplace.dart';

String apiurl = "http://10.0.2.2:8000/api/retrieveTimeline/";

List data;

String image;

class Timeline extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TimelineState();
  }
}

class TimelineState extends State<Timeline> {

  void getTimelineData(BuildContext context) async {
    var response = await http
        .get(Uri.encodeFull(apiurl), headers: {"Accept": "application/json"});

      var convertJsonToData = json.decode(response.body);
      data = convertJsonToData;
  }

  
  @override
  void initState() {
    super.initState();
    this.getTimelineData(context);
  }

  

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
         floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.indigo,
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
          backgroundColor: Colors.indigo,
        ),
        body: _timeline())
      );
       
  }

  Widget _timeline() {
    return data != null && data.length != null && data.length > 0
        ? ListView.builder(
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
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                trailing: Text(
                                  data[index]['date'],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                  child:Image.network(data[index]["image"])),
                              ListTile(
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
            })
        : Container(
            child: Center(
              child: Text("No timelines yet"),
            ),
          );
  }
}
