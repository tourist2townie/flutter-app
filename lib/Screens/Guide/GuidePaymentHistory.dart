import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GuidePaymentHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment history"),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.orangeAccent.withOpacity(0.3)
        ),
          child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Card(
              elevation: 5.0,
              color: Colors.teal,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(15.0),
                  ),
                  ListTile(
                    leading:Text("Journey",
                        style: Theme.of(context).textTheme.title,
                      ),
                    trailing: Text("Nine arch",style: Theme.of(context).textTheme.title,),
                  ),
                  ListTile(
                    leading: Text("Date :",style: Theme.of(context).textTheme.body2,),
                    trailing: Text("2018/08/16",style: Theme.of(context).textTheme.body2,),
                  ),
                  ListTile(
                    leading: Text("Payment : ",style: Theme.of(context).textTheme.body2,),
                    trailing: Text("11500 LKR",style: Theme.of(context).textTheme.body2,),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
            ),
            Card(
              elevation: 5.0,
              color: Colors.teal,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(15.0),
                  ),
                  ListTile(
                    leading: Text("Journey :",style: Theme.of(context).textTheme.title,),
                    trailing: Text("Upper diyaluma",style: Theme.of(context).textTheme.title,),
                  ),
                  ListTile(
                    leading: Text("Date :",style: Theme.of(context).textTheme.body2,),
                    trailing: Text("2018/08/16",style: Theme.of(context).textTheme.body2,),
                  ),
                  ListTile(
                    leading: Text("Payment : ",style: Theme.of(context).textTheme.body2,),
                    trailing: Text("4500 LKR",style: Theme.of(context).textTheme.body2,),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
            ),
            Card(
              elevation: 5.0,
              color: Colors.teal,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(15.0),
                  ),
                  ListTile(
                    leading: Text("Journey :",style: Theme.of(context).textTheme.title,),
                    trailing: Text("Pidurangala",style: Theme.of(context).textTheme.title,),
                  ),
                  ListTile(
                    leading: Text("Date :",style: Theme.of(context).textTheme.body2,),
                    trailing: Text("2018/08/16",style: Theme.of(context).textTheme.body2,),
                  ),
                  ListTile(
                    leading: Text("Payment : ",style: Theme.of(context).textTheme.body2,),
                    trailing: Text("6500 LKR",style: Theme.of(context).textTheme.body2,),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
            ),
            Card(
              elevation: 5.0,
              color: Colors.teal,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(15.0),
                  ),
                  ListTile(
                    leading: Text("Journey :",style: Theme.of(context).textTheme.title,),
                    trailing: Text("Sigiriya",style: Theme.of(context).textTheme.title,),
                  ),
                  ListTile(
                    leading: Text("Date :",style: Theme.of(context).textTheme.body2,),
                    trailing: Text("2018/08/16",style: Theme.of(context).textTheme.body2,),
                  ),
                  ListTile(
                    leading: Text("Payment : ",style: Theme.of(context).textTheme.body2,),
                    trailing: Text("6500 LKR",style: Theme.of(context).textTheme.body2,),
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
