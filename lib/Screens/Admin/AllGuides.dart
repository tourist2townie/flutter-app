import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tt/utils/ResponseData.dart';

import 'GuideProfileAdmin.dart';

class ViewAllGuides extends StatefulWidget {
  @override
  _ViewAllGuidesState createState() => _ViewAllGuidesState();
}

class _ViewAllGuidesState extends State<ViewAllGuides> {

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
      ResponseData.noOfGuides = convertJsonToData.length.toString();
        data = convertJsonToData;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _allGuideList(),
    );
  }

  Widget _allGuideList(){
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
                        color: Colors.indigo,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)
                        ),
                        semanticContainer: true,
                        child: ListTile(
                          selected: false,
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
                                  builder: (context) => GuideProfileAdmin()),
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