import 'package:flutter/material.dart';

import 'Chatroom.dart';

class GuideProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _alertBox() {
      
    }

    Future<void> _neverSatisfied() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return _alertBox();
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Request for guide"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Card(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 50.0),
                    ),
                    Card(
                        child: Container(
                      child: Column(
                        children: <Widget>[
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
            ListTile(
              title: Text("Experience :"),
              trailing: Text("5 years"),
            ),
            ListTile(
              title: Text("Current Rating :"),
              trailing: Text("4.9"),
            ),
            ListTile(
              title: Text("Current Badge :"),
              trailing: Icon(Icons.card_travel),
            ),
            RaisedButton(
              onPressed: () {
                _neverSatisfied();
              },
              child: Text(
                "Send Request",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.teal,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
            )
          ],
        ),
      ),
    );
  }
}
