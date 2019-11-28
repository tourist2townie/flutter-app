import 'dart:io';
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';
import 'package:tt/Widgets/LabelTextField.dart';
import 'package:http/http.dart' as http;
import 'package:tt/utils/ResponseData.dart';

String uploadedFileURL;

String apiUrl = "http://10.0.2.2:8000/api/profileUpdate/${ResponseData.userId}";

class UpdateProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return UpdateProfileState();
  }
}

class UpdateProfileState extends State<UpdateProfile> {
  TextEditingController newNameController = TextEditingController();
  TextEditingController newEmailController = TextEditingController();

  static File _image;

  getImage(ImageSource source) async {
    var image = await ImagePicker.pickImage(source: source);
    _image = image;
    setState(() {});
  }

  Future uploadFile() async {
    FirebaseUser user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: 'sandun@gmail.com', password: "sandun");
    final String fileName = DateTime.now().toString();
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child("images/$fileName");
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    // await uploadTask.onComplete;
    print('File Uploaded');
    uploadedFileURL = await(await uploadTask.onComplete).ref.getDownloadURL();

    editData();
    print(uploadedFileURL);
  }

  void editData() {
    http.put(apiUrl, headers: {
      'Accept': 'application/json',
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjliNTg2MWVlNTg0ZGJkZGI5MDc1NDc3YTQ1ZDQ3ZDM5NGNiMzU2ZGIxZjBhMjUwZDUyZjk0YmViNGQwOTM3NTI0ZTM0MGNhMzBiYWM5NDAwIn0.eyJhdWQiOiIxIiwianRpIjoiOWI1ODYxZWU1ODRkYmRkYjkwNzU0NzdhNDVkNDdkMzk0Y2IzNTZkYjFmMGEyNTBkNTJmOTRiZWI0ZDA5Mzc1MjRlMzQwY2EzMGJhYzk0MDAiLCJpYXQiOjE1NTg1NTMyMTMsIm5iZiI6MTU1ODU1MzIxMywiZXhwIjoxNTkwMTc1NjEzLCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.sFIfXVx72efT54J40TVkqh3rwMGW-anTulNMDnVvGh_eO_qz0oKRl56JYCBwPQchc7fTbG5ZkVwaf_oU85rzjq3hrgXaOIzOoaNYsAKTOpPVbPi26bqpMLCWFe26hZO3BmS_kCSSD_-WlYVOlEw5oXQt1_MHV1eBt0tbXFLkgNwvkFr9IOvySINVsDOVoCArvp2Cx-XYthIP-0JuC7yQny5byMKerRGDO8pIjKLnPTTi9YWo36KU1SlzqoK-IJrQFvi5ir-rKk93IFCXwNoRN9QwXATb_4uJJyhpv2WLtXQwpnlPFqQFad8L0I8y9pfyzXnDtl3Aq1G3OlZMHbKcXp4uV8uByuT7UzI_FW6a0ion3Id1P3wy65n-X2OW2rDH6cpoCaz5_yzkpUfeo5WQ0RpG7q_VbWon2rf2NpbV8Jyzg80Woz3eNaQPA8-hdR5qUeeGXXulwfcT_sQln2uBmC3Ke2gbI1cKrBa4gVFpip9055lhgXfKzBvNkhV2dUljawBGacb0p4C1irkz6ygTzMu_31r2KHuzXiKQvbaEmorHGOLdvrwr-L2cqUmM3_jeAMmrV2_Pe4nRJHsvOLOYpB6ELNdeX8_DhD7DWUa6pdeU2PpRsXvwaGLbAkah9z7hCa54HGCzSLJPhN813nTXHuK_biSxIlH5n3ruvHiP6Rw'
    }, body: {
      "name": newNameController.text,
      "email": newEmailController.text,
      'profile_image': uploadedFileURL.toString(),
    }).then((response) {
      if (response.statusCode == 200) {
        Navigator.pop(context);
        Toast.show("Succesfuly updated", context);
      } else {
        print('Response status : ${response.statusCode}');
        print(response.body);
      }
    });
  }

  @override
  void initState() {
    print(ResponseData.userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Update Profile"),
          backgroundColor: Colors.teal,
        ),
        body: Builder(builder: (context) {
          return Form(
            autovalidate: true,
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 16,
                      ),
                      LabelTextField(
                        hintText: "Enter new username",
                        labelText: "New username",
                        validator: null,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      LabelTextField(
                        textEditingController: newNameController,
                        hintText: "Enter new name",
                        labelText: "New name",
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      LabelTextField(
                        textEditingController: newEmailController,
                        hintText: "Enter new Email address",
                        labelText: "New Email address",
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Center(
                          child: _image == null
                              ? (IconButton(
                                  icon: Icon(Icons.photo_camera),
                                  onPressed: () =>
                                      getImage(ImageSource.gallery),
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
                                  ],
                                )),
                      Center(
                        child: ButtonTheme(
                            height: 50.0,
                            child: RaisedButton(
                              onPressed: () {
                                uploadFile();
                              },
                              child: Text("Update"),
                              color: Colors.teal,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(80.0)),
                            )),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        }));
  }
}
