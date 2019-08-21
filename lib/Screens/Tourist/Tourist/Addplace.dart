import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tt/Widgets/LabelTextField.dart';

class AddPlace extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddPlaceState();
  }
}

class AddPlaceState extends State<AddPlace> {
  File _image;

  getImage(ImageSource source) async {
    var image = await ImagePicker.pickImage(source: source);
    _image = image;
    setState(() {});
  }

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
                      padding: EdgeInsets.only(
                        top: 50.0,
                      ),
                    ),
                    Center(
                        child: _image == null
                            ? (IconButton(
                                icon: Icon(Icons.photo_camera),
                                onPressed: () => getImage(ImageSource.gallery),
                                iconSize: 40.0,
                                splashColor: Colors.orange,
                              ))
                            : Column(
                                children: <Widget>[
                                  Image.file(
                                    _image,
                                    height: 200,
                                    width: 500,
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.done),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    iconSize: 30.0,
                                  )
                                ],
                              )),
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
