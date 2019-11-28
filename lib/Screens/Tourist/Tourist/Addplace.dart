import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:image_picker/image_picker.dart';
import 'package:tt/Screens/Tourist/Tourist/Timeline.dart';
import 'package:tt/Widgets/LabelTextField.dart';
import 'package:http/http.dart' as http;
import 'package:tt/main_screen.dart';

String apiurl = "http://10.0.2.2:8000/api/addTimeline/";
String uploadedFileURL;

class AddPlace extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddPlaceState();
  }
}

class AddPlaceState extends State<AddPlace> {
  TextEditingController place = TextEditingController();
  TextEditingController date = TextEditingController();
  File _image;

   Future uploadFile() async {
    FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: "sandun@gmail.com", password: "sandun");
    final String fileName = DateTime.now().toString();
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child("timeline/$fileName");
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    // await uploadTask.onComplete;
    print('File Uploaded');
    uploadedFileURL = await (await uploadTask.onComplete).ref.getDownloadURL();
    addTimeline(context);
    print(uploadedFileURL);
  }

  void addTimeline(BuildContext context) async {
    final Map<String, dynamic> data = {
      'place': place.text,
      'date': date.text,
      'image': uploadedFileURL.toString()
    };
    var response = await http.post(apiurl,
        body: data, encoding: Encoding.getByName("application/json"));

    if (response.statusCode == 200) {
      Navigator.push(context,MaterialPageRoute(
        builder: (context)=>MainScreen()
      ));
      print("clicked");
    }
  }

  getImage(ImageSource source) async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    _image = image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add your favorite photos"),
        backgroundColor: Colors.indigo,
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
                      textEditingController: place,
                      hintText: "Place you went",
                      labelText: "Enter name of the place",
                      validator: null,
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    LabelTextField(
                      textEditingController: date,
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
                                onPressed: () => getImage(ImageSource.camera),
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
                                      uploadFile();
                                      prefix0.Navigator.pop(context);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Timeline()));
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
