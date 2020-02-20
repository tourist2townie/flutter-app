import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';
import 'package:tt/Screens/Tourist/Tourist/Timeline.dart';
import 'package:tt/Widgets/LabelTextField.dart';
import 'package:http/http.dart' as http;

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
  DateTime _jorneyDate;

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
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Timeline()));
      print("clicked");
    }
    // uploadFile();
  }

  getImage(ImageSource source) async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
    _image = image;
    });
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
                    _jorneyDate == null
                        ? ListTile(
                            trailing: IconButton(
                              icon: Icon(Icons.calendar_today),
                              onPressed: () {
                                showDatePicker(
                                  context: context,
                                  firstDate: DateTime(2000),
                                  initialDate: DateTime.now(),
                                  lastDate: DateTime(2100),
                                ).then((date) {
                                  setState(() {
                                    _jorneyDate = date;
                                  });
                                });
                              },
                            ),
                            title: LabelTextField(
                              hintText: 'Date',
                              labelText: "Journey Date",
                              keyboardType: TextInputType.datetime,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'This field cant be empty';
                                }
                                return null;
                              },
                              textEditingController: date,
                            ),
                          )
                        : LabelTextField(
                            hintText: 'Date',
                            labelText: _jorneyDate.toString(),
                            keyboardType: TextInputType.datetime,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'This field cant be empty';
                              }
                              return null;
                            },
                            textEditingController: date,
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
                                      if (place.text.isEmpty == true ||
                                          date.text.isEmpty == true) {
                                        Toast.show(
                                            "Make sure data fields are filled",
                                            context);
                                      } else {
                                        uploadFile();
                                      }
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
