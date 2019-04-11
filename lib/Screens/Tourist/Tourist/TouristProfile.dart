import 'package:flutter/material.dart';

class TouristProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TouristProfileState();
}

class _TouristProfileState extends State<TouristProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Your profile"),
        backgroundColor: Colors.teal,
      ),
      body:Container(
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
              title: Text("Trips :"),
              trailing: Text("13 successful"),
            ),
            ListTile(
              title: Text("Current Rating :"),
              trailing: Text("4.9"),
            ),
            ListTile(
              title: Text("Current Badge :"),
              trailing: Icon(Icons.card_travel),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
              label: Text("Photo album"),
              onPressed: (){},
              backgroundColor: Colors.teal,
              icon: Icon(Icons.photo_album),
            ),

            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            
    );
  }
}
