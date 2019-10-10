import 'package:flutter/material.dart';
import 'package:tt/Widgets/LabelTextField.dart';

class ReportGuide extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ReportGuideState();
  }
}

class ReportGuideState extends State<ReportGuide> {
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
                        hintText: 'Reason',
                        labelText: 'Enter your Reason for reporting',
                        validator: null),
                    SizedBox(
                      height: 16,
                    ),
                    LabelTextField(
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
                          Navigator.pop(context);
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
