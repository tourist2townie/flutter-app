import 'package:flutter/material.dart';

class ChatroomGuide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<void> _alertReport() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Report the user'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text("Submit your reason.."),
                  TextFormField(
                    maxLines: 2,
                  ),
                ],
              ),
            ),
            actions: <Widget>[
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

    Future<void> _alertCancel() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirm to cancel the trip'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                      'Cancelling the trip will cause reducion of your xp badge'),
                  Text(""),
                  Text('Certain inquires will be taken by us..'),
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

    return Scaffold(
      appBar: AppBar(
        title: Text("Chat with %guide"),
        titleSpacing: 15.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.cancel),
            onPressed: () {
              _alertCancel();
            },
          ),
          IconButton(
            icon: Icon(Icons.report),
            onPressed: () {
              _alertReport();
            },
          ),
        ],
      ),
      body: Text("Tourist can chat with guide here.."),
    );
  }
}
