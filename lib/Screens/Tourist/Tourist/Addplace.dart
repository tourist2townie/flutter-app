import 'package:flutter/material.dart';
import 'package:tt/Widgets/LabelTextField.dart';

class AddPlace extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddPlaceState();
  }
}

class AddPlaceState extends State<AddPlace> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add your favorite photos.."),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.teal.withOpacity(0.1),
        ),
        child: Form(
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 16,
                    ),
                    LabelTextField(
                      hintText: "Place you went",
                      labelText: "Enter name of the place",
                      validator: null,
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    LabelTextField(
                      hintText: "Date",
                      labelText: "Date you went",
                      validator: null,
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: 150.0,),
                    ),
                    Center(
                      child: IconButton(
                        
                        icon: Icon(Icons.photo_camera),
                        onPressed: (){},
                        iconSize: 40.0,
                        splashColor: Colors.orange,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
