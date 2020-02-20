import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:tt/Screens/Guide/main_screen.dart';
import 'package:tt/Screens/Tourist/Tourist/RegistrationPage.dart';
import 'package:tt/main_screen.dart';
import 'package:tt/utils/ResponseData.dart';
import 'package:tt/Screens/Admin/MainScreen.dart';

String username;
String type;
String apiUrl = "http://10.0.2.2:8000/api";
var id, value;
String userId;

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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

  void loginFunc(BuildContext context) async {
    final Map<String, dynamic> data = {
      "email": _email.text.toLowerCase(),
      "password": _password.text,
    };

    if (_email.text == "admin" && _password.text == "admin") {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MainScreenAdmin()));
    } else {
      var response = await http.post(apiUrl + '/login',
          body: data, encoding: Encoding.getByName("application/json"));

      print(response.statusCode);

      if (response.statusCode != 200) {
        print("cant rout");

        Fluttertoast.showToast(msg: "Check credentials login failed");
      } else {
        value = json.decode(response.body);
        var type = (value["user"]["userType"]).toString();
        id = (value["user"]["id"]).toString();
        print(id);
        id == null
            ? Fluttertoast.showToast(msg: "Invalid login")
            : ResponseData.userId = (value['user']['id']).toString();
        if (type == "guide") {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => GuideMainScreen()));
        } else if (type == "tourist") {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MainScreen()));
        }

        // Toast.show("Login Successfull", context, duration: Toast.LENGTH_LONG);
        Fluttertoast.showToast(msg: "Login Successfull");
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
                  image: AssetImage("assets/images/login.png"),
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
                padding: EdgeInsets.only(top: 120.0),
                child: Column(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(top: 60.0)),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      padding: EdgeInsets.only(
                          top: 4.0, left: 16.0, right: 16.0, bottom: 4.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          color: Colors.white.withOpacity(0.7)),
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter email';
                          }
                          return null;
                        },
                        controller: _email,
                        decoration: InputDecoration(
                            icon: Icon(
                              Icons.email,
                              color: Colors.indigo,
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
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        color: Colors.white.withOpacity(0.7),
                      ),
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter email';
                          }
                          return null;
                        },
                        controller: _password,
                        obscureText: true,
                        decoration: InputDecoration(
                            icon: Icon(
                              Icons.vpn_key,
                              color: Colors.indigo,
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
                color: Colors.amber.withOpacity(0.9),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                onPressed: () {
                  if (_password.text.isEmpty == true &&
                      _email.text.isEmpty == true) {
                    Fluttertoast.showToast(msg: "Cant keep fields empty");
                  } else {
                    loginFunc(context);
                  }
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Dont have account?",
                    style: TextStyle(fontSize: 15.0, color: Colors.white),
                  ),
                  FlatButton(
                    child: Text(
                      "Register here  ",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    color: Colors.transparent,
                    onPressed: () {
                      _navRegistrationPage();
                      // Navigator.push(context,MaterialPageRoute(builder: (context)=>Chatroom()));
                    },
                  ),
                ],
              )
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
