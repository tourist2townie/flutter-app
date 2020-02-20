import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tt/Screens/Admin/GuideProfileAdmin.dart';
import 'package:tt/utils/ResponseData.dart';
import 'package:url_launcher/url_launcher.dart';

class payments extends StatefulWidget {
  @override
  _paymentsState createState() => _paymentsState();
}

class _paymentsState extends State<payments> {
  List data;
  String apiurl = "http://10.0.2.2:8000/api/getalltripPrices/";

  @override
  void initState() {
    super.initState();
    this.getalltripPrices(context);
  }

  void getalltripPrices(BuildContext context) async {
    var response = await http
        .get(Uri.encodeFull(apiurl), headers: {"Accept": "application/json"});

    if (this.mounted) {
      setState(() {
        var convertJsonToData = json.decode(response.body);
        data = convertJsonToData;
      });
    }
  }

  _launchURL() async {
  const url = 'https://sandbox.payhere.lk/account/user';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.indigo,
            onPressed: () {
              _launchURL();
            }, label: Text("Visit pay here site")),
        body: _paymentList());
  }

  Widget _paymentList() {
    return data != null && data.length != null && data.length > 0
        ? ListView.builder(
            itemCount: data.length == null ? 0 : data.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: Card(
                  color: Colors.indigo,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    children: <Widget>[
                      InkWell(
                        onTap: (){
                          ResponseData.searchedGuide = data[index]['id'].toString();
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>GuideProfileAdmin()));
                        },
                        child: ListTile(
                          leading: Text("Guide :",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                          trailing: Text(
                            data[index]["guide_id"].toString(),
                          style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),)),
                      ),
                      SizedBox(height: 6),
                      ListTile(
                          leading: Text("province :",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                          trailing: Text(
                            data[index]["province"],
                          style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),)),
                      SizedBox(height: 6),
                      ListTile(
                          leading: Text("Days :",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                          trailing: Text(
                            data[index]["days"].toString(),
                          style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),)),
                      SizedBox(height: 6),
                      ListTile(
                        leading: Text("Price :",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                        trailing: Text(data[index]["price"].toString(),style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                      ),
                      SizedBox(height: 6),
                    ],
                  ),
                ),
              );
            })
        : Container(
            child: Center(
              child: Text("No tours yet"),
            ),
          );
  }
}
