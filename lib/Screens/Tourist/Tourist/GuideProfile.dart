import 'package:flutter/material.dart';
import 'package:tt/Screens/Tourist/Tourist/Chatroom.dart';
import 'package:tt/Screens/Tourist/Tourist/TripRequest.dart';

class GuideProfileTourist extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GuideProfileTouristState();
  }
}

class GuideProfileTouristState extends State<GuideProfileTourist> {
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
                                  AssetImage("assets/images/profileAvatar.jpg"),
                              radius: 80.0,
                            ),
                            ListTile(
                              // contentPadding: EdgeInsets.only(left: 150.0),
                              title: Text(
                                " Moor",
                                textAlign: TextAlign.center,
                              ),
                              subtitle: Text(
                                "moor@email.com",
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
                          ButtonTheme(
                            height: 40.0,
                            minWidth: 150.0,
                            child: RaisedButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>TripRequest()));
                              },
                              child: Text(
                                "Request for a trip",
                                style: TextStyle(color: Colors.white),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                              color: Colors.teal,
                            ),
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
