import 'dart:convert';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tt/Chatroom/Chatroom.dart';
import 'package:tt/Widgets/PackageCorousel.dart';
import 'package:tt/utils/ResponseData.dart';

import '../GuideProfile.dart';

String apiurlHike =
    "http://10.0.2.2:8000/api/getPackages/${ResponseData.userId}/Hike";


class HikePackages extends StatefulWidget {
  @override
  _HikePackagesState createState() => _HikePackagesState();
}

class _HikePackagesState extends State<HikePackages> {
  List data;
  String category, guide_id, date, province, type,price,tourist_id;
  int days;

  @override
  void initState() {
    this.getPackagesHike(context);
    super.initState();
  }

  void getPackagesHike(BuildContext context) async {
    var response = await http.get(Uri.encodeFull(apiurlHike),
        headers: {"Accept": "application/json"});

    if (this.mounted) {
      setState(() {
        var convertJsonToData = json.decode(response.body);
        data = convertJsonToData;
      });
    }
  }


  void _makeTripRequest(BuildContext context) async {
String apiurl =
      'http://10.0.2.2:8000/api/makeTour?guide_id=$guide_id&tourist_id=${ResponseData.userId}';
    final Map<String, dynamic> data = {
      'category': type,
      'guide_id': guide_id.toString(),
      'date': date,
      'No_of_days': days.toString(),
      'status': "Occupied",
      'tourist_id':ResponseData.userId.toString(),
      'province':province,
      'price':price.toString(),
    };
    var response = await http.post(apiurl,
        body: data, encoding: Encoding.getByName("application/json"));
    if(response.statusCode == 200){
      print("jdnfjdf");
    }
  }

  @override
  Widget build(BuildContext context) {
    return _packageList();
  }

  Widget _packageList() {
    return data != null && data.length != null && data.length > 0
        ? ListView.builder(
            itemCount: data.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              type = data[index]["category"];
              guide_id = data[index]["guide_id"].toString();
              tourist_id = ResponseData.userId.toString();
              date = data[index]["date"];
              days = data[index]["days"];
              province = data[index]["province"];
              price = data[index]["price"].toString();

              return Card(
                child: ExpandableNotifier(
                    child: ScrollOnExpand(
                  scrollOnExpand: false,
                  scrollOnCollapse: true,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        PackageCorousel(),
                        ScrollOnExpand(
                          scrollOnExpand: true,
                          scrollOnCollapse: false,
                          child: ExpandablePanel(
                            tapHeaderToExpand: true,
                            tapBodyToCollapse: true,
                            headerAlignment:
                                ExpandablePanelHeaderAlignment.center,
                            header: Padding(
                              padding: EdgeInsets.all(10),
                              child: ListTile(
                                  title: Text(
                                data[index]['category'],
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              )),
                            ),
                            collapsed: RaisedButton(
                              onPressed: () {
                                _makeTripRequest(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Chatroom()));
                              },
                              child: Text("Request for package"),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                              color: Colors.teal,
                            ),
                            expanded: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  child: Column(
                                    children: <Widget>[
                                      Card(
                                        color: Colors.indigo.withOpacity(0.3),
                                        child: ListTile(
                                          leading: Text("Guide",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold)),
                                          trailing: Text(data[index]['guide_id']
                                              .toString()),
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        GuideProfileTourist()));
                                          },
                                        ),
                                      ),
                                      Card(
                                        color: Colors.indigo.withOpacity(0.3),
                                        child: ListTile(
                                          leading: Text(
                                            "Date",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          trailing: Text(data[index]['date']),
                                        ),
                                      ),
                                      Card(
                                        color: Colors.indigo.withOpacity(0.3),
                                        child: ListTile(
                                          leading: Text("Province",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold)),
                                          trailing:
                                              Text(data[index]['province']),
                                        ),
                                      ),
                                      Card(
                                        color: Colors.indigo.withOpacity(0.3),
                                        child: ListTile(
                                          leading: Text("No of days",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold)),
                                          // trailing: Text(date[index][days].toString()),
                                        ),
                                      ),
                                      Center(
                                        child: RaisedButton(
                                          onPressed: () {
                                            _makeTripRequest(context);
                                            print(type);
                                          },
                                          child: Text("Request for package"),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0)),
                                          color: Colors.teal,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            builder: (_, collapsed, expanded) {
                              return Padding(
                                padding: EdgeInsets.only(
                                    left: 10, right: 10, bottom: 10),
                                child: Expandable(
                                  collapsed: collapsed,
                                  expanded: expanded,
                                  crossFadePoint: 0,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
              );
            },
          )
        : Container(
            child: Center(
              child: Text(
                "Currently no packages",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo),
              ),
            ),
          );
  }
}
