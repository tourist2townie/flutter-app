import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:tt/utils/ResponseData.dart';
import 'package:http/http.dart' as http;
import 'Transaction.dart';
import 'TripStatus.dart';

String id = ResponseData.onGoingTripId;
// String id = "2";
List data;
var convertJasonToData;
int i = 0;
String tourtype, place, days;

String apiurl2 =
    'http://10.0.2.2:8000/api/retrieveOngoingTrip/';
String apiUrl =
    "http://10.0.2.2:8000/api/tripStatusUpdate/${ResponseData.onGoingTripId}";

class OngoingTrip extends StatefulWidget {
  @override
  _OngoingTripState createState() => _OngoingTripState();
}

class _OngoingTripState extends State<OngoingTrip> {
  @override
  void initState() {
    super.initState();

    this.onGoingTrip(context);

    
  }

  void onGoingTrip(BuildContext context) async {
    print(apiUrl);
    var response = await http
        .get(Uri.encodeFull(apiurl2), headers: {"Accept": "application/json"});
    convertJasonToData = json.decode(response.body);
    if(convertJasonToData != null){
    if (convertJasonToData['status'] == "Ongoing" || convertJasonToData['status'] == null) {
      print("sdnlk");
    } else
      print(apiurl2);
  }else{
    
  }

  setState(() {
      tourtype = convertJasonToData['tour_type'];
      place = convertJasonToData['place'];
      days = convertJasonToData['No_of_days'].toString();
    });
  }
  void editTriptatus() {
    http.put(apiUrl, headers: {
      'Accept': 'application/json',
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjliNTg2MWVlNTg0ZGJkZGI5MDc1NDc3YTQ1ZDQ3ZDM5NGNiMzU2ZGIxZjBhMjUwZDUyZjk0YmViNGQwOTM3NTI0ZTM0MGNhMzBiYWM5NDAwIn0.eyJhdWQiOiIxIiwianRpIjoiOWI1ODYxZWU1ODRkYmRkYjkwNzU0NzdhNDVkNDdkMzk0Y2IzNTZkYjFmMGEyNTBkNTJmOTRiZWI0ZDA5Mzc1MjRlMzQwY2EzMGJhYzk0MDAiLCJpYXQiOjE1NTg1NTMyMTMsIm5iZiI6MTU1ODU1MzIxMywiZXhwIjoxNTkwMTc1NjEzLCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.sFIfXVx72efT54J40TVkqh3rwMGW-anTulNMDnVvGh_eO_qz0oKRl56JYCBwPQchc7fTbG5ZkVwaf_oU85rzjq3hrgXaOIzOoaNYsAKTOpPVbPi26bqpMLCWFe26hZO3BmS_kCSSD_-WlYVOlEw5oXQt1_MHV1eBt0tbXFLkgNwvkFr9IOvySINVsDOVoCArvp2Cx-XYthIP-0JuC7yQny5byMKerRGDO8pIjKLnPTTi9YWo36KU1SlzqoK-IJrQFvi5ir-rKk93IFCXwNoRN9QwXATb_4uJJyhpv2WLtXQwpnlPFqQFad8L0I8y9pfyzXnDtl3Aq1G3OlZMHbKcXp4uV8uByuT7UzI_FW6a0ion3Id1P3wy65n-X2OW2rDH6cpoCaz5_yzkpUfeo5WQ0RpG7q_VbWon2rf2NpbV8Jyzg80Woz3eNaQPA8-hdR5qUeeGXXulwfcT_sQln2uBmC3Ke2gbI1cKrBa4gVFpip9055lhgXfKzBvNkhV2dUljawBGacb0p4C1irkz6ygTzMu_31r2KHuzXiKQvbaEmorHGOLdvrwr-L2cqUmM3_jeAMmrV2_Pe4nRJHsvOLOYpB6ELNdeX8_DhD7DWUa6pdeU2PpRsXvwaGLbAkah9z7hCa54HGCzSLJPhN813nTXHuK_biSxIlH5n3ruvHiP6Rw'
    }, body: {
      "status": "Completed",
    }).then((response) {
      if (response.statusCode == 200) {
        print('Response status : ${response.statusCode}');
        Toast.show("Trip completed", context);
      } else {
        print('Response body : ${response.body}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Ongoing trip'),
          backgroundColor: Colors.teal,
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Completed trips',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TripStatus())),
            )
          ],
        ),
        body: Container(
          decoration:
              BoxDecoration(color: Colors.orangeAccent.withOpacity(0.2)),
          child: Center(
              child: Card(
            elevation: 10.0,
            margin: EdgeInsets.all(20.0),
            child: Container(
              decoration:
                  BoxDecoration(color: Colors.orangeAccent.withOpacity(0.2)),
              height: 500.0,
              width: 600.0,
              child: Column(
                children: <Widget>[
                  Card(
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            leading: Text('Trip type:',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            trailing: Text(
                                tourtype == null ? "No Ongoing trips" : tourtype,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          ListTile(
                            leading: Text(
                              'place:',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            trailing: Text(
                                place == null ? "No Ongoing trips" : place,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10.0),
                          ),
                          ListTile(
                            leading: Text('No of Days remaining:',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            trailing: Text(
                                days == null ? "Still loading" : days,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10.0),
                          ),
                          ListTile(
                            leading: Text('Guide:',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            trailing: Text('Sameera',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                            height: 140.0,
                          ),
                          ButtonTheme(
                            height: 50.0,
                            minWidth: 300.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            child:days==null? AbsorbPointer(
                              absorbing: true,
                               child:RaisedButton(
                                color: Colors.teal,
                                child: Text(
                                  "Complete Trip",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  onGoingTrip(context);
                                  editTriptatus();
                                  // completeTrip(context);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Transaction(),
                                      ));
                                }),

                            ): RaisedButton(
                                color: Colors.teal,
                                child: Text(
                                  "Complete Trip",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  onGoingTrip(context);
                                  editTriptatus();
                                  // completeTrip(context);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Transaction(),
                                      ));
                                }),
                          ),
                          SizedBox(
                            height: 58.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
        ));
  }
}