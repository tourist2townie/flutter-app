import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tt/utils/ResponseData.dart';


class TouristProfileGuide extends StatefulWidget {
  @override
  _TouristProfileGuideState createState() => _TouristProfileGuideState();
}

class _TouristProfileGuideState extends State<TouristProfileGuide> {

  String apiUrl = "http://10.0.2.2:8000/api/profileRetrieveGuide/${ResponseData.searchedTourist}";
  String name;
  String email;
  String image;


  @override
  void initState() {
    this.loadProfile(context);
    super.initState();
  }


   void loadProfile(BuildContext context) async {
    var response = await http
        .get(Uri.encodeFull(apiUrl), headers: {"Accept": "application/json"});

    if (this.mounted) {
      var convertJasonToData = json.decode(response.body);
      
      setState(() {
        name = convertJasonToData["name"];
        email = convertJasonToData["email"];
        image = convertJasonToData['profile_image'];
      });
    }

    // image = convertJasonToData["profile_image"];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Tourist profile"),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Card(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 15.0),
                      ),
                      Card(
                          child: Container(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 15.0),
                            ),
                            CircleAvatar(
                              backgroundImage:
                                  NetworkImage(image!=null?image:""),
                              radius: 80.0,
                            ),
                            ListTile(
                              // contentPadding: EdgeInsets.only(left: 150.0),
                              title: Text(
                                name == null ? 'Still loading' : name,
                                textAlign: TextAlign.center,
                              ),
                              subtitle: Text(
                                email == null ? 'Still loading' : email,
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.black),
                              ),

                              isThreeLine: true,
                            )
                          ],
                        ),
                      )),
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Stack(
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            color: Colors.teal,
                            child: ListTile(
                              title: Text("Trips :"),
                              trailing: Text("13 successful"),
                            ),
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            color: Colors.teal,
                            child: ListTile(
                              title: Text("Current Rating :"),
                              trailing: Text("4.9"),
                            ),
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            color: Colors.teal,
                            child: ListTile(
                              title: Text("Current Badge :"),
                              trailing: Icon(Icons.card_travel),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}