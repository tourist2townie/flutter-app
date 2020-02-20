import 'dart:convert';

import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:tt/Widgets/LabelTextField.dart';
import 'package:http/http.dart' as http;

class ComposePackage extends StatefulWidget {
  @override
  _ComposePackageState createState() => _ComposePackageState();
}

class _ComposePackageState extends State<ComposePackage> {
  String apiUrl = "http://10.0.2.2:8000/api/postPackages";

  TextEditingController _tripType = TextEditingController();
  TextEditingController _province = TextEditingController();
  TextEditingController _date = TextEditingController();
  TextEditingController _noOfDays = TextEditingController();
  TextEditingController _price = TextEditingController();
  // TextEditingController _noOfDays = TextEditingController();

  Map<String, dynamic> formData;
  List<String> types = [
    'Hike',
    'Beach',
    'Adventure',
    'Historical',
  ];

  _ComposePackageState() {
    formData = {
      // 'Type': 'Hike',
    };
  }
  DateTime _tripDate;
  void composePackage(BuildContext context) async {
    final Map<String, dynamic> data = {
      "category": _tripType.text,
      "province": _province.text,
      "days": _noOfDays.text,
      "date": _tripDate.toString(),
      "price": _price.text,
      "status": "pending",
      "guide_id": "0",
      "tourist_id": "0",
    };

    var response = await http.post(apiUrl,
        body: data, encoding: Encoding.getByName("application/json"));
    if (response.statusCode == 200) {
      Toast.show("Successfully registered", context,
          gravity: Toast.LENGTH_LONG);

      Navigator.pop(context);
    } else {
      print("error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Compose package"),
        backgroundColor: Colors.indigo,
      ),
      body: _composeBody(),
    );
  }

  Widget _composeBody() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 12,
        ),
        DropDownField(
            value: formData['Type'],
            required: true,
            hintText: 'Choose a type',
            labelText: 'Type *',
            items: types,
            strict: true,
            controller: _tripType,
            setter: (dynamic newValue) {
              formData['Type'] = newValue;
            }),
        SizedBox(
          height: 12,
        ),
        LabelTextField(
          hintText: "Province",
          labelText: "Province",
          textEditingController: _province,
        ),
        SizedBox(
          height: 12,
        ),
        _tripDate == null
            ? ListTile(
                trailing: IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      initialDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    ).then((date) {
                      setState(() {
                        _tripDate = date;
                      });
                    });
                  },
                ),
                title: LabelTextField(
                  hintText: 'Date',
                  labelText: "Trip Date",
                  keyboardType: TextInputType.datetime,
                  validator: null,
                  textEditingController: _date,
                ),
              )
            : LabelTextField(
                hintText: 'Date',
                labelText: _tripDate.toString(),
                keyboardType: TextInputType.datetime,
                validator: null,
                textEditingController: _date,
              ),
        SizedBox(
          height: 12,
        ),
        LabelTextField(
          hintText: "No of days",
          labelText: "No of days",
          textEditingController: _noOfDays,
        ),
        SizedBox(
          height: 12,
        ),
        LabelTextField(
          hintText: "price",
          labelText: "price",
          textEditingController: _price,
        ),
        Center(
          child: FlatButton(
            onPressed: () {
              if (_province.text.isEmpty == true ||
                  _date.text.isEmpty == true ||
                  _province.text.isEmpty == true ||
                  _noOfDays.text.isEmpty == true ||
                  _price.text.isEmpty == true) {
                Toast.show("Cant keep fields empty", context);
              } else {
                composePackage(context);
              }
            },
            child: Text(
              "Publish",
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.indigo,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        )
      ],
    );
  }
}
