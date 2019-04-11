import 'package:flutter/material.dart';

class GuideDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Guide Dashboard"),
      ),
      body: Container(
        decoration: BoxDecoration(boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.6),
            blurRadius: 3.0,
          ),
        ]),
        height: 300.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.blue,
              child: Icon(Icons.account_circle,color: Colors.black,),
            ),
          ],
        )
      ),
    );
  }
}
