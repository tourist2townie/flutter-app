import 'dart:convert';
import 'dart:core';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:tt/Screens/Tourist/Tourist/TouristProfileUpdate.dart';
import 'package:http/http.dart' as http;
import 'package:tt/utils/ResponseData.dart';
import 'AutoPhotoLoader.dart';
import 'OngoingTripCell.dart';

String uid = ResponseData.userId;
String name;
String image;
String email;
String apiUrl = "http://10.0.2.2:8000/api/profileRetrieve/${ResponseData.userId}";

class TouristProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TouristProfileState();
}

class _TouristProfileState extends State<TouristProfile> {
  List data;

  @override
  void initState() {
    super.initState();

    this.loadProfile(context);
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
        title: Text("Your profile"),
        backgroundColor: Colors.teal,
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
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Photo album"),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CarouselPhotoLoader()));
        },
        backgroundColor: Colors.teal,
        icon: Icon(Icons.photo_album),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
                Center(
                    child: ButtonTheme(
                  height: 50.0,
                  child: RaisedButton(
                    color: Colors.teal,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0)),
                    onPressed: () {
                      loadProfile(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UpdateProfile()));
                    },
                    child: Text("Update profile"),
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
