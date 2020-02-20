import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tt/Screens/Guide/GuideProfileUpdate.dart';
import 'package:http/http.dart' as http;
import 'package:tt/Widgets/LabelTextField.dart';
import 'package:tt/utils/ResponseData.dart';

String uid = ResponseData.userId;
String name;
String image;
String email;
String apiUrl =
    "http://10.0.2.2:8000/api/profileRetrieve/${ResponseData.userId}";

String apiUrlforPlaces =
    "http://10.0.2.2:8000/api/getGuidingPlaces/${ResponseData.userId}";

String guidingPlace = "http://10.0.2.2:8000/api/addGuidingPlace";

class GuideProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GuideProfileState();
}

class _GuideProfileState extends State<GuideProfile> {
  List data;
  File _image;
  String location;

  TextEditingController newPlace = TextEditingController();

  void loadPlaces(BuildContext context) async {
    var places = await http.get(Uri.encodeFull(apiUrlforPlaces),
        headers: {'Accept': 'application/json'});
    if (this.mounted) {
      var placesData = json.decode(places.body);
      data = placesData;
      print(data.length);
    }
  }

  @override
  void initState() {
    super.initState();
    print(apiUrlforPlaces);
    this.loadProfile(context);
    this.loadPlaces(context);
  }

  String uploadedFileURL;

  getImage(ImageSource source) async {
    var image = await ImagePicker.pickImage(source: source);
    _image = image;
    setState(() {});
  }

  void loadProfile(BuildContext context) async {
    var response = await http
        .get(Uri.encodeFull(apiUrl), headers: {"Accept": "application/json"});

    if (this.mounted) {
      var convertJasonToData = json.decode(response.body);

      setState(() {
        name = convertJasonToData["name"];
        email = convertJasonToData["email"];
        image = convertJasonToData['profile_image'];
      });
    }
  }

  void addGuidingPlace() async {
    final Map<String, dynamic> data = {
      'place': newPlace.text,
      'guide_id': ResponseData.userId.toString(),
      'guide_name': name
    };

    if (newPlace.text.isEmpty == true) {
      Fluttertoast.showToast(msg: "Cant keep field empty");
    } else {
      var response = await http.post(guidingPlace,
          body: data, encoding: Encoding.getByName("application/json"));

      if(response.statusCode == 200){
         Fluttertoast.showToast(msg: "Successfully added place");
        //  Navigator.pop(context);
      }else{
        Fluttertoast.showToast(msg: "Oops something is not right !!");
      }
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(name != null ? name : 'still loading'),
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              _profileImageSection(),
              _profileDetailsSection(),
              _guidePlacesSection(),
              _confirmButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _profileDetailsSection() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Stack(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  color: Colors.teal,
                  child: ListTile(
                    title: Text("Trips :"),
                    trailing: Text("13 successful"),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  color: Colors.teal,
                  child: ListTile(
                    title: Text("Current Rating :"),
                    trailing: Text("4.9"),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  color: Colors.teal,
                  child: ListTile(
                    title: Text("Current Badge :"),
                    trailing: Icon(Icons.card_travel),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _confirmButton() {
    return Center(
        child: ButtonTheme(
      height: 50.0,
      child: RaisedButton(
        color: Colors.teal,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        onPressed: () {
          // loadProfile(context);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => GuideProfileUpdate()));
        },
        child: Text("Update profile"),
      ),
    ));
  }
  Widget _profileImageSection() {
    return Card(
      child: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 15.0),
            ),
            Card(
                child: Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 15.0),
                  ),
                  profile(),
                  ListTile(
                    // contentPadding: EdgeInsets.only(left: 150.0),
                    title: Text(
                      name == null ? 'Still loading' : name,
                      textAlign: TextAlign.center,
                    ),
                    subtitle: Text(
                      email == null ? 'still loading' : email,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black),
                    ),
                    isThreeLine: true,
                  )
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget profile() {
    return CircularProfileAvatar(
      image != null ? image : "https://avatars2.githubusercontent.com/u/4641831?s=400&v=4",
      radius: 100,
      backgroundColor: Colors.transparent,
      borderWidth: 10,
      initialsText: Text(
        (name != null ? (name[0] + name[1]) : "Loading").toUpperCase(),
        style: TextStyle(fontSize: 40, color: Colors.white),
      ),
      borderColor: Colors.brown,
      elevation: 5.0,
      foregroundColor: Colors.brown.withOpacity(0.5),
      cacheImage: true,
      onTap: () {
        getImage(ImageSource.gallery);
      }, // sets on tap
      showInitialTextAbovePicture: true,
    );
  }

  Widget _guidePlacesSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Wrap(
        spacing: 5.0,
        children: <Widget>[
          data != null && data.length != null && data.length > 0
              ? ListView.builder(
                  itemCount: data.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext ctx, int index) {
                    return InputChip(
                        backgroundColor: Colors.indigo,
                        label: Text(
                          data[index]['place'],
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {},
                        avatar: CircleAvatar(
                          radius: 30.0,
                          backgroundImage: NetworkImage(image),
                          backgroundColor: Colors.transparent,
                        ));
                  },
                )
              : Container(
                  child: CircularProgressIndicator(),
                ),
          Align(
            alignment: Alignment.bottomRight,
            child: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                _showNoteDialog(context);
              },
              color: Colors.indigo,
              iconSize: 40,
            ),
          )
        ],
      ),
    );
  }

  void _showNoteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Add a place you prefered'),
        content: LabelTextField(
          hintText: "Enter place",
          labelText: "Place",
          textEditingController: newPlace,
        ),
        actions: <Widget>[
          FlatButton(
              child: Text('OK'),
              onPressed: () {
                addGuidingPlace();
              })
        ],
      ),
    );
  }
}
