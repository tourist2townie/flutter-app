import 'package:flutter/material.dart';
import 'package:tt/utils/uidata.dart';
import 'dart:async';

import 'Screens/Tourist/Tourist/Login.dart';

void main() {
  runApp(MaterialApp(
     title: UIData.appName,
    theme: ThemeData(
        primaryColor: Colors.black,
        fontFamily: UIData.quickFont,
        primarySwatch: Colors.amber),
    debugShowCheckedModeBanner: false,
    showPerformanceOverlay: false,
    home: Login(),
  ));
}

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => Login())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.black,
      child: Center(
        child: FlutterLogo(
          colors: Colors.yellow,
          size: 150.0,
        ),
      ),
    ));
  }
}
