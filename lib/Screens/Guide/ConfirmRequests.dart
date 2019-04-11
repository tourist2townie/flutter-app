import 'package:flutter/material.dart';

import 'AdminContact.dart';
import 'Chatroom.dart';
import 'GuideDashboard.dart';

class ConfirmRequests extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final drawerHeader = UserAccountsDrawerHeader(
      decoration: BoxDecoration(color: Colors.black),
      accountName: Text('User name'),
      accountEmail: Text('username@gmail.com'),
      currentAccountPicture: CircleAvatar(
        child: Icon(
          Icons.account_circle,
          size: 42.0,
        ),
        backgroundColor: Colors.white,
      ),
    );

    final drawerItems = ListView(
      children: <Widget>[
        drawerHeader,
        ListTile(
          leading: Icon(
            Icons.account_circle,
            color: Colors.blue,
          ),
          title: Text(
            "Profile",
          ),
          onTap: () {
//            Navigator.push(
//              context,
//              MaterialPageRoute(builder: (context) => user()),
//            );
          },
        ),
        ListTile(
          leading: Icon(
            Icons.dashboard,
            color: Colors.red,
          ),
          title: Text("Dashboard"),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => GuideDashboard()));
          },
        ),
        ListTile(
          leading: Icon(
            Icons.payment,
            color: Colors.green,
          ),
          title: Text("Payment history"),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(
            Icons.contact_phone,
            color: Colors.cyanAccent,
          ),
          title: Text("Contact Admin"),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AdminContact()),
            );
          },
        ),
        ListTile(
          leading: Icon(
            Icons.settings,
            color: Colors.brown,
          ),
          title: Text("Settings"),
          onTap: () {},
        ),
      ],
    );
    Future<void> _CongirmTrip() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirm to accept trip'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                      'If you gona cancel later you will have to tell us the reason'),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('Confirm'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChatroomGuide()),
                  );
                },
              ),
            ],
          );
        },
      );
    }

    Future<void> _Cancel_Trip() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirm to Cancel reuest'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                      'If you gona cancel you will have to tell us the reason'),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('Confirm'),
                onPressed: () {
                  Navigator.pop(
                    context,
                  );
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      drawer: Drawer(
        child: drawerItems,
      ),
      appBar: AppBar(
        title: Text("Trip Requests"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.contact_mail),
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AdminContact()));
            },
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          backgroundBlendMode: BlendMode.luminosity
        ),
        child: Column(
          children: <Widget>[
            Card(
              child: ListTile(
                leading: Icon(Icons.assistant_photo),
                title: Text("Request from neo"),
                trailing: IconButton(icon: Icon(Icons.cancel), onPressed: null),
                onTap: () {
                  _CongirmTrip();
                },
                dense: false,
              ),
              color: Colors.green,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              margin: EdgeInsets.all(6.0),
              clipBehavior: Clip.antiAlias,
              elevation: 8.0,
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.ac_unit),
                title: Text("Request from Jhon"),
                trailing: IconButton(
                    icon: Icon(Icons.cancel),
                    onPressed: () {
                      _Cancel_Trip();
                    }),
                onTap: () {
                  _CongirmTrip();
                },
              ),
              color: Colors.green,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              margin: EdgeInsets.all(6.0),
              clipBehavior: Clip.antiAlias,
              elevation: 8.0,
            ),
          ],
        ),
      ),
    );
  }
}
