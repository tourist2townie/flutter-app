import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tt/Screens/Tourist/Tourist/OngoingTrip.dart';
import 'package:tt/Widgets/AnimatedFab.dart';
import 'package:tt/utils/ResponseData.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'GuideProfile.dart';
import 'ReportGuide.dart';

String name;
int length;
String apiurl = "http://10.0.2.2:8000/api/retrieveGuides/";
var guide;
int Datalength;

List data;

class Hike extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HikeState();
  }
}

class HikeState extends State<Hike> {
  @override
  void initState() {
    super.initState();
    this.getGuidesData(context);
  }

  void getGuidesData(BuildContext context) async {
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
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/hike_bac.jpg"),
                  fit: BoxFit.cover)),
          child: ListView.builder(
            itemCount: data.length == 0 ? 0 : data.length,
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
                        color: Colors.transparent,
                        semanticContainer: true,
                        child: ListTile(
                          selected: false,
                          onLongPress: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ReportGuide()));
                          },
                          leading: CircleAvatar(
                            minRadius: 3.0,
                            maxRadius: 25.0,
                            backgroundImage:
                                AssetImage("assets/images/circle_avatar.jpg"),
                          ),
                          title: Text(
                            data[index]['name'],
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.0),
                          ),
                          trailing: Text(
                            "3.2",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.0),
                          ),
                          onTap: () {
                            ResponseData.guideId = (data[index]['id']);
                            print(ResponseData.guideId);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GuideProfileTourist()),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        floatingActionButton: AnimatedFab());
  }
}
