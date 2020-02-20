import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tt/Screens/Tourist/Tourist/JoinTrip.dart';
import 'package:tt/main_screen.dart';
import 'package:tt/utils/ResponseData.dart';
import 'package:http/http.dart' as http;

import 'GuideProfile.dart';
import 'ReportGuide.dart';

class AllGuides extends StatefulWidget {
  @override
  _AllGuidesState createState() => _AllGuidesState();
}

class _AllGuidesState extends State<AllGuides> {
  List data;
  String apiurl = "http://10.0.2.2:8000/api/retrieveGuides/";
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
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context,MaterialPageRoute(builder: (context)=>MainScreen()));
          },
        ),
        title: Center(
          child: Text("All guides"),
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
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/All-guides-bac.jpg"),
                  fit: BoxFit.fitHeight)),
          child: showGuides()),
    );
  }

  Widget showGuides() {
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
                        color: Colors.transparent,
                        semanticContainer: true,
                        child: ListTile(
                          selected: false,
                          onLongPress: () {
                            ResponseData.reportuser = (data[index]['id']).toString();
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
                          onTap: () {
                            ResponseData.searchedGuide =
                                (data[index]['id']).toString();
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
            })
        : Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }
}
