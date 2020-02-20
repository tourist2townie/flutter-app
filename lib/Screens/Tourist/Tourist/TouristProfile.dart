import 'dart:convert';
import 'dart:core';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:tt/Screens/Tourist/Tourist/TouristProfileUpdate.dart';
import 'package:http/http.dart' as http;
import 'package:tt/utils/ResponseData.dart';
import 'OngoingTripCell.dart';

String uid = ResponseData.userId;
String name;
String image;
String email;
String apiUrl =
    "http://10.0.2.2:8000/api/profileRetrieve/${ResponseData.userId}";

String tripsUrl =
    "http://10.0.2.2:8000/api/retrieveTrips/${ResponseData.userId}";

class TouristProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TouristProfileState();
}

class _TouristProfileState extends State<TouristProfile> {
  Map data;
  double rating;
  int tripsconut;

  @override
  void initState() {
    super.initState();

    this.loadProfile(context);
    this.retrieveTrips(context);
    
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
  }

  void retrieveTrips(BuildContext context) async {
    var response = await http
        .get(Uri.encodeFull(apiUrl), headers: {"Accept": "application/json"});

    if (this.mounted) {
      data = json.decode(response.body.toString());
      
      tripsconut = data['rating'];
       print(data);
       print(response.body);


    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Your profile"),
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              _profileImageSection(),
              _profileDetailsSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _profileDetailsSection() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Stack(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  color: Colors.indigo,
                  child: ListTile(
                    title: Text("Trips :",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                    trailing: Text( "11 Successfull",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  color: Colors.indigo,
                  child: ListTile(
                    title: Text("Current Rating :",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                    trailing: Text("4.3",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  color: Colors.indigo,
                  child: ListTile(
                    title: Text("Current Badge :",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                    trailing: Icon(Icons.card_travel,color: Colors.white,),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                ),
                Center(
                    child: ButtonTheme(
                  height: 50.0,
                  child: RaisedButton(
                    color: Colors.indigo,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0)),
                    onPressed: () {
                      loadProfile(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UpdateProfile()));
                    },
                    child: Text("Update profile",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _profileImageSection() {
    return Card(
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
                  _profileAvatar(),
                  ListTile(
                    // contentPadding: EdgeInsets.only(left: 150.0),
                    title: Text(
                      name == null ? 'Still loading' : name,
                      textAlign: TextAlign.center,
                    ),
                    subtitle: Text(
                      email == null ? 'slitt loading' : email,
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
    );
  }

  Widget _profileAvatar() {
    return AvatarGlow(
      shape: BoxShape.circle,
      startDelay: Duration(milliseconds: 1000),
      glowColor: Colors.blue,
      endRadius: 120.0,
      duration: Duration(milliseconds: 2000),
      repeat: true,
      showTwoGlows: true,
      repeatPauseDuration: Duration(milliseconds: 100),
      child: Material(
        elevation: 8.0,
        shape: CircleBorder(),
        child: CircleAvatar(
          backgroundColor: Colors.grey[100],
          child: ClipOval(
            child: Image.network(
              profileImageUrl != null ? profileImageUrl : "",
              fit: BoxFit.cover,
              height: 200,
              width: 200,
            ),
          ),
          radius: 70,
        ),
      ),
    );
  }
}
