import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tt/Chatroom/Chatroom.dart';
import 'package:tt/Widgets/Txt.dart';
import 'package:tt/utils/ResponseData.dart';

String uId = ResponseData.userId;
String apiurl = "http://10.0.2.2:8000/api/retrieveRequestedTours/";
List data;
int i = 0;

var detailResponse;

class RequestedTrips extends StatefulWidget {
  @override
  _RequestedTripsState createState() => _RequestedTripsState();
}

class _RequestedTripsState extends State<RequestedTrips> {
  @override
  void initState() {
    super.initState();
    this.getRequestedTrips(context);
  }

  void getRequestedTrips(BuildContext context) async {
    var response = await http
        .get(Uri.encodeFull(apiurl), headers: {"Accept": "application/json"});

    if (this.mounted) {
      setState(() {
        var convertJsonToData = json.decode(response.body);
        data = convertJsonToData;

        // print(data[0]["status"]);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Requested trips"),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.orangeAccent.withOpacity(0.2)),
        child: ListView.builder(
            itemCount: data.length == null ? 0 : data.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10.0),
                    ),
                    Card(
                      child: ListTile(
                          leading: Txt(
                            text: data[index]['tour_type'],
                          ),
                          title: Txt(
                            text: data[index]['place'],
                            fontWeight: FontWeight.bold,
                          ),
                          subtitle: Text("Guide name- Sameera"),
                          onLongPress: () {
                            print('cancel trip');
                          },
                          onTap: () {
                            detailResponse = data[index]['id'];
                            print("");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Chatroom()));
                            ResponseData.onGoingTripId = detailResponse.toString();
                          },
                          isThreeLine: true,
                          trailing: Text(data[index]['date'])),
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}
