import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tt/Widgets/LabelTextField.dart';
import 'package:http/http.dart' as http;
import 'package:tt/utils/ResponseData.dart';

String apiurl = "http://10.0.2.2:8000/api/reportGuide";

class ReportGuide extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ReportGuideState();
  }
}

class ReportGuideState extends State<ReportGuide> {
  TextEditingController _reason = TextEditingController();
  TextEditingController _desc = TextEditingController();

  void report(BuildContext context) async {
    final Map<String, dynamic> data = {
      'reason': _reason.text,
      'desctription': _desc.text,
      'tourist_id': ResponseData.userId.toString(),
      'guide_id': ResponseData.reportuser.toString(),
    };
    var response = await http.post(apiurl,
        body: data, encoding: Encoding.getByName("application/json"));

    if (response.statusCode == 200) {
      Navigator.pop(context);
      print("clicked");
    } else {
      print(ResponseData.userId);
      print(ResponseData.reportuser);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Report guide"),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.orangeAccent.withOpacity(0.2)),
        child: Form(
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 16,
                    ),
                    LabelTextField(
                        textEditingController: _reason,
                        hintText: 'Reason',
                        labelText: 'Enter your Reason for reporting',
                        validator: null),
                    SizedBox(
                      height: 16,
                    ),
                    LabelTextField(
                        textEditingController: _desc,
                        hintText: 'Discription',
                        labelText: 'Enter your about inconvinence you faced',
                        validator: null),
                    SizedBox(
                      height: 16,
                    ),
                    ButtonTheme(
                      height: 40.0,
                      minWidth: 150.0,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        color: Colors.teal,
                        onPressed: () {
                          if(_reason.text.isEmpty == true){
                            Fluttertoast.showToast(msg: "Reason cant be empty");
                          }else{  
                          report(context);
                          }
                          print(_desc.text);
                          print(_reason.text);
                        },
                        child: Text(
                          "Submit",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
