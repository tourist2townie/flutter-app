import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tt/Widgets/AnimatedFab.dart';

import 'GuideProfile.dart';
import 'ReportGuide.dart';

String apiurl = "http://10.0.2.2:8000/api/retrieveGuides/";
String name;
int length;

List data;

class Adventure extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AdventureState();
  }
}

class AdventureState extends State<Adventure> {
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
        length = data.length;
      });

      dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/adven_bac.jpg"),
                fit: BoxFit.cover)),
        child: showGuides()
      ),
      floatingActionButton: AnimatedFab(),
    );
  }

  Widget showGuides(){
    return data!=null && data.length !=null && data.length>0? ListView.builder(
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
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                        trailing: Text(
                          "3.2",
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                        onTap: () {
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
        ):Container(
          child: Center(
            child: CircularProgressIndicator(),
          )
        );
  }
}
