import 'package:flutter/material.dart';
import 'package:tt/Screens/Tourist/Tourist/Chatroom.dart';
import 'package:tt/Widgets/LabelTextField.dart';

class TripRequest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TripRequestState();
  }
}

class TripRequestState extends State<TripRequest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        label: Text(
          "Chat room",
        ),
        icon: Icon(Icons.chat),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatRoom()));
        },
        backgroundColor: Colors.teal,
      ),
      appBar: AppBar(
        title: Text("Requesting the trip"),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.orangeAccent.withOpacity(0.2)),
        child: Form(
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 16,
                    ),
                    LabelTextField(
                        hintText: 'Trip type',
                        labelText: 'Enter trip type',
                        validator: null),
                    SizedBox(
                      height: 16,
                    ),
                    LabelTextField(
                        hintText: 'Trip place',
                        labelText: 'Enter place you want to travel',
                        validator: null),
                    SizedBox(
                      height: 16,
                    ),
                    LabelTextField(
                        hintText: 'Date',
                        labelText: 'Journey date',
                        keyboardType: TextInputType.datetime,
                        validator: null),
                    SizedBox(
                      height: 16,
                    ),
                    LabelTextField(
                        hintText: 'No of days',
                        labelText: 'No of days',
                        keyboardType: TextInputType.number,
                        validator: null),
                    SizedBox(
                      height: 16,
                    ),
                    Center(
                      child: RaisedButton(
                        onPressed: () {},
                        child: Text(
                          "Sumbit request",
                          style: TextStyle(color: Colors.white),
                        ),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                        color: Colors.teal,
                      ),
                    )
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
