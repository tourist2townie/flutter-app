import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tt/Screens/Admin/AdminMain.dart';
import 'package:tt/Screens/Guide/GuideFirst.dart';
import 'package:tt/Screens/Tourist/Tourist/TouristProfile.dart';
import 'package:tt/utils/uidata.dart';

import 'ContactAdmin.dart';
import 'First.dart';
import 'JoinTrip.dart';
import 'Notifications.dart';
import 'RegistrationPage.dart';

String username;
String type;
String apiUrl = "http://10.0.2.2:8000/api";

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       routes: <String, WidgetBuilder>{
      UIData.TouristProfile: (BuildContext context) => TouristProfile(),
      UIData.JoinTrip: (BuildContext context) => JoinTrip(),
      UIData.Notifications: (BuildContext context) => Notifications(),
      UIData.ContactAdmin: (BuildContext context) => ContactAdmin(),
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

  void loginFunc(BuildContext) async {
    print(_email.text + ':' + _password.text);
    final Map<String, dynamic> data = {
      "email": _email.text,
      "password": _password.text
    };

    if (_email.text == "admin" && _password.text == "admin") {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => AdminMain()));
    } else {
      var response = await http.post(apiUrl + '/login',
          body: data, encoding: Encoding.getByName("application/json"));
      print("------------------------");
      print(response.body.toString());
      print("------------------------");

      var value = json.decode(response.body.toString());
      print(value["user"]["usertype"]);
      var type = (value["user"]["userType"]).toString();
      
      if (type == "guide") {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePageGuide()));
      } else if (type == "tourist") {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
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
                  image: AssetImage("assets/images/login.jpg"),
                  fit: BoxFit.cover)),
          child: Column(
            children: <Widget>[
              
              Container(
                padding: EdgeInsets.only(top: 77.0),
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
                            hintText: 'Username'),
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
//              Spacer(),
              RaisedButton(
                child: Text("Login"),
                color: Colors.teal.withOpacity(0.9),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                onPressed: () {
                  loginFunc(context);
                  print("login");
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
