import 'package:flutter/material.dart';

class GuidePaymentHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment history"),
        backgroundColor: Colors.teal,
      ),
      body: Container(
          child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Card(
              elevation: 5.0,
              color: Colors.teal.withOpacity(0.4),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(15.0),
                  ),
                  ListTile(
                    leading: Text("Journey :"),
                    trailing: Text("Nine arch"),
                  ),
                  ListTile(
                    leading: Text("Date :"),
                    trailing: Text("2018/08/16"),
                  ),
                  ListTile(
                    leading: Text("Payment : "),
                    trailing: Text("11500 LKR"),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
            ),
            Card(
              elevation: 5.0,
              color: Colors.teal.withOpacity(0.4),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(15.0),
                  ),
                  ListTile(
                    leading: Text("Journey :"),
                    trailing: Text("Upper diyaluma"),
                  ),
                  ListTile(
                    leading: Text("Date :"),
                    trailing: Text("2018/08/16"),
                  ),
                  ListTile(
                    leading: Text("Payment : "),
                    trailing: Text("4500 LKR"),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
            ),
            Card(
              elevation: 5.0,
              color: Colors.teal.withOpacity(0.4),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(15.0),
                  ),
                  ListTile(
                    leading: Text("Journey :"),
                    trailing: Text("Pidurangala"),
                  ),
                  ListTile(
                    leading: Text("Date :"),
                    trailing: Text("2018/08/16"),
                  ),
                  ListTile(
                    leading: Text("Payment : "),
                    trailing: Text("6500 LKR"),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
            ),
            Card(
              elevation: 5.0,
              color: Colors.teal.withOpacity(0.4),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(15.0),
                  ),
                  ListTile(
                    leading: Text("Journey :"),
                    trailing: Text("Sigiriya"),
                  ),
                  ListTile(
                    leading: Text("Date :"),
                    trailing: Text("2018/08/16"),
                  ),
                  ListTile(
                    leading: Text("Payment : "),
                    trailing: Text("6500 LKR"),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
