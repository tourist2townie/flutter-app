import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tt/Screens/Admin/TouristProfileAdmin.dart';
import 'package:tt/utils/ResponseData.dart';

class ViewAllTourists extends StatefulWidget {
  @override
  _ViewAllTouristsState createState() => _ViewAllTouristsState();
}

class _ViewAllTouristsState extends State<ViewAllTourists> {
  List data;
  String apiurl = "http://10.0.2.2:8000/api/getAllTourists/";

  @override
  void initState() {
    super.initState();
    this.getTouristData(context);
  }

  void getTouristData(BuildContext context) async {
    var response = await http
        .get(Uri.encodeFull(apiurl), headers: {"Accept": "application/json"});

    if (this.mounted) {
      setState(() {
        var convertJsonToData = json.decode(response.body);
        data = convertJsonToData;

        ResponseData.noOfGuides = convertJsonToData.length.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _allTouristList(),
    );
  }

  Widget _allTouristList() {
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
                            borderRadius: BorderRadius.circular(8)),
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
                            ResponseData.searchedTourist =
                                (data[index]['id']).toString();
                            print(ResponseData.searchedGuide);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TouristProfileAdmin()),
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