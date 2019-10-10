import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tt/Screens/Tourist/Tourist/AutoPhotoLoader.dart';
import 'package:tt/Screens/Tourist/Tourist/TouristProfileUpdate.dart';
import 'package:tt/utils/ResponseData.dart';
import 'package:http/http.dart' as http;

String apiUrl = "http://10.0.2.2:8000/api/profileRetrieveGuide/2";

String name;
String email;


class GuideProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GuideProfileState();
}

class GuideProfileState extends State<GuideProfile> {

  List data;

    @override
  void initState() {
     super.initState();

     this.loadProfile(context);
     }

  void loadProfile(BuildContext context) async{
    var response= await http.get( Uri.encodeFull(apiUrl),
      headers: {"Accept":"application/json"});

      var convertJasonToData = json.decode(response.body);
      
      setState(() {
        name==null?name="Still loading":
        name= convertJasonToData["name"];
        email==null?email="Still loading":
        email= convertJasonToData["email"];
      });

      print(response.body);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Your profile"),
        backgroundColor: Colors.teal,
      ),
      body:SingleChildScrollView(
        child:  Container(
        child: Column(
          children: <Widget>[
            Card(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top:15.0),
                    ),
                    Card(
                        child: Container(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top:15.0),   
                          ),
                          CircleAvatar(
                            backgroundImage:
                                AssetImage("assets/images/profileAvatar.jpg"),
                            radius: 80.0,
                          ),
                          ListTile(
                            // contentPadding: EdgeInsets.only(left: 150.0),
                            title:Text(
                              name,
                              textAlign: TextAlign.center,
                            ),
                            subtitle: Text(
                              email,
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
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                          color: Colors.teal,
                          child: ListTile(
                            title: Text("Trips :"),
                            trailing: Text("13 successful"),
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                          color: Colors.teal,
                          child: ListTile(
                            title: Text("Current Rating :"),
                            trailing: Text("4.9"),
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
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
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                            onPressed: (){
                              loadProfile(context);
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context)=>UpdateProfile()
                              ));
                            },
                            child: Text("Update profile"),
                          ),
                          )
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
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Photo album"),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder:(context)=>CarouselPhotoLoader()) );
        },
        backgroundColor: Colors.teal,
        icon: Icon(Icons.photo_album),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
