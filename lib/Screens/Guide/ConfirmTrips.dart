import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tt/Widgets/MyClipper.dart';
import 'package:tt/utils/ResponseData.dart';
import 'package:http/http.dart' as http;

String apiUrl = "http://10.0.2.2:8000/api/tripRequests/${ResponseData.userId}";
List data;

class ConfirmTrips extends StatefulWidget {
  @override
  _ConfirmTripsState createState() => _ConfirmTripsState();
}

class _ConfirmTripsState extends State<ConfirmTrips> {
  @override
  void initState() {
    this.getTripRequests(context);
    print(apiUrl);
    super.initState();
  }

  void getTripRequests(BuildContext context) async {
    var response = await http
        .get(Uri.encodeFull(apiUrl), headers: {"Accept": "application/json"});

    if (this.mounted) {
      setState(() {
        var convertJsonToData = json.decode(response.body);
        data = convertJsonToData;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: ListView(
      children: <Widget>[
        ClipPath(
          clipper: MyClipper(),
          child: Container(
            height: 320,
            decoration: BoxDecoration(color: Colors.indigo),
            child: Center(
              child: Text(
                "Requested Trips",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 40),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
        ),
        _body()
      ],
    )));
  }

  Widget _body() {
    return Container();
  }
}
