import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart' as prefix0;
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'package:tt/Chatroom/Chatroom.dart';
import 'package:tt/Screens/Admin/AdminMain.dart';
import 'package:tt/Screens/Guide/ConfirmRequest.dart';
import 'package:tt/Screens/Guide/GuideFirst.dart';
import 'package:tt/Screens/Guide/GuidePaymentHistory.dart';
import 'package:tt/Screens/Guide/GuideProfile.dart';
import 'package:tt/Screens/Guide/GuideTimeline.dart';
import 'package:tt/Screens/Tourist/Tourist/Payments.dart';
import 'package:tt/Screens/Tourist/Tourist/RegistrationPage.dart';
import 'package:tt/Screens/Tourist/Tourist/Timeline.dart';
import 'package:tt/Screens/Tourist/Tourist/TouristProfile.dart';
import 'package:tt/utils/ResponseData.dart';
import 'package:tt/utils/uidata.dart';

import 'First.dart';
import 'JoinTrip.dart';
import 'Notifications.dart';

String username;
String type;
String apiUrl = "http://10.0.2.2:8000/api";
var id;
String userId;

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: <String, WidgetBuilder>{
        UIData.TouristProfile: (BuildContext context) => TouristProfile(),
        UIData.JoinTrip: (BuildContext context) => JoinTrip(),
        UIData.TouristPhotos: (BuildContext context) => CarouselDemo(),
        UIData.Timeline: (BuildContext context) => Timeline(),
        UIData.Payment: (BuildContext context) => Payments(),
        UIData.ChatRoom: (BuildContext context) => Chatroom(),
        UIData.GuideProfile: (BuildContext context) => GuideProfile(),
        UIData.ConfirmRequest: (BuildContext context) => ConfirmRequest(),
        UIData.ChatRoom: (BuildContext context) => Chatroom(),
        UIData.GuideTimeline: (BuildContext context) => GuideTimeline(),
        UIData.GuidePhotos: (BuildContext context) => CarouselDemo(),
        UIData.GuidePaymentHistory: (BuildContext context) =>
            GuidePaymentHistory(),
      },
      title: 'Tourist 2 Townie',
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static TextEditingController _email = TextEditingController();
  static TextEditingController _password = TextEditingController();

  Map user;

  void loginFunc(BuildContext context, String _email, String _password) async {
    print(_email + ':' + _password);
    final Map<String, dynamic> data = {
      "email": _email,
      "password": _password,
    };

    if (_email == "admin" && _password == "admin") {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => AdminMain()));
    } else {
      var response = await http.post(apiUrl + '/login',
          body: data, encoding: Encoding.getByName("application/json"));

      print(response.statusCode);
      var value = json.decode(response.body);
      var type = (value["user"]["userType"]).toString();
      id = (value["user"]["id"]).toString();
      ResponseData.userId = (value['user']['id']).toString();

      if (response.statusCode == 200) {
        if (type == "guide") {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => HomePageGuide()));
        } else if (type == "tourist") {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        }

        Toast.show("Login Successfull", context,duration:Toast.LENGTH_LONG);
      } else {
        print("cant rout");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Form(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/login_new.jpg"),
                  fit: BoxFit.cover)),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 70.0),
                width: 170.0,
                height: 170.0,
                decoration: BoxDecoration(shape: BoxShape.circle),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(top: 93.0),
                child: Column(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(top: 60.0)),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      padding: EdgeInsets.only(
                          top: 4.0, left: 16.0, right: 16.0, bottom: 4.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5.0,
                            )
                          ]),
                      child: TextFormField(
                        controller: _email,
                        decoration: InputDecoration(
                            icon: Icon(
                              Icons.email,
                              color: Colors.black,
                            ),
                            hintText: 'Email'),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      height: 50.0,
                      margin: EdgeInsets.only(top: 32.0),
                      padding: EdgeInsets.only(
                          top: 4.0, left: 16.0, right: 16.0, bottom: 4.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5.0,
                            )
                          ]),
                      child: TextField(
                        controller: _password,
                        obscureText: true,
                        decoration: InputDecoration(
                            icon: Icon(
                              Icons.vpn_key,
                              color: Colors.black,
                            ),
                            hintText: 'Password'),
                      ),
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 6.0, right: 32.0),
                ),
              ),
              RaisedButton(
                child: Text("Login"),
                color: Colors.teal.withOpacity(0.9),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                onPressed: () {
                  loginFunc(context, "sandun@gmail.com", "sandun");
                },
              ),
              Text(
                "Dont have account? Register here",
                style: TextStyle(fontSize: 15.0, color: Colors.white),
              ),
              RaisedButton(
                child: Text("Register"),
                color: Colors.teal.withOpacity(0.9),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                onPressed: () {
                  _navRegistrationPage();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navRegistrationPage() {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => RegistrationPage()));
  }
}
