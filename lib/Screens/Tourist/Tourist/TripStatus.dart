import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tt/Chatroom/Chatroom.dart';
import 'package:tt/utils/ResponseData.dart';
import 'package:http/http.dart' as http;

String uId = ResponseData.userId;
String apiurl = "http://10.0.2.2:8000/api/retrieveRequestedTours/";
List data;
Color color;

class TripStatus extends StatefulWidget {
  @override
  _TripStatusState createState() => _TripStatusState();
}

class _TripStatusState extends State<TripStatus> {
  static String detailResponse;
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
        //shard pref instead of 1
        data = convertJsonToData;
      });
      // for(int i=0;i<data.length;i++){
      //   if (data[i]['status'] == "Pending") {
      //     color = Colors.teal;
      //   }
      //   else if (data[i]['status'] == "Completed") {
      //     color = Colors.red;
      //   }else{
      //     color = Colors.blue;
      //   }
      // }
    }
  }

  String pendingStatus = 'Status: Pending';
  String completedStatus = 'Status: Completed';
  String ongoingStatus = 'Status: Ongoing';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All trips"),
        backgroundColor: Colors.teal,
      ),
      body: Container(
          decoration:
              BoxDecoration(color: Colors.orangeAccent.withOpacity(0.2)),
          child: data != null && data.length != null && data.length > 0
              ? ListView.builder(
                  itemCount: data.length == null ? 0 : data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(10.0),
                          ),
                          Card(
                            color: color,
                            child: Container(
                              child: ListTile(
                                leading: Text(
                                  data[index]['tour_type'],
                                ),
                                title: Text(
                                  data[index]['place'],
                                ),
                                subtitle: Text(
                                  "Guide name- Sameera" +
                                      '\n ' +
                                      'Status :' +
                                      data[index]['status'],
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                onLongPress: () {
                                  print('cancel trip');
                                },
                                onTap: () {
                                  ResponseData.onGoingTripId =
                                      data[index]['id'].toString();
                                  detailResponse = ResponseData.onGoingTripId;
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Chatroom()));
                                  print(detailResponse);
                                },
                                isThreeLine: true,
                                trailing: Text(data[index]['date']),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )
              : Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )),
    );
  }
}
