import 'package:flutter/material.dart';

import 'GuideProfile.dart';

class Adventure extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Adventure guides"),
        ),
        body: Container(
          padding: EdgeInsets.only(top: 40.0),
          child: Column(
            children: <Widget>[
              Text(
                "Here the guide list. Choose one of them",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                ),
              ),
              ListTile(
                title: Text("Guide 1"),
                trailing: Text("4.4"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GuideProfile()),
                  );
                },
              ),
              ListTile(
                title: Text("Guide 2"),
                trailing: Text("3.2"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GuideProfile()),
                  );
                },
              ),
              ListTile(
                title: Text("Guide 3"),
                trailing: Text("3.2"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GuideProfile()),
                  );
                },
              ),
              ListTile(
                title: Text("Guide 4"),
                trailing: Text("4.4"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GuideProfile()),
                  );
                },
              ),
              ListTile(
                title: Text("Guide 5"),
                trailing: Text("4.4"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GuideProfile()),
                  );
                },
              ),
              Text(
                "All guides in db will be retrieved",
                style: TextStyle(color: Colors.black12),
              )
            ],
          ),
        ));
  }
}
