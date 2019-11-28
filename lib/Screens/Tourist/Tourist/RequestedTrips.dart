import 'dart:convert';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:folding_cell/folding_cell/widget.dart';
import 'package:http/http.dart' as http;
import 'package:tt/Chatroom/Chatroom.dart';
import 'package:tt/Widgets/MyClipper.dart';
import 'package:tt/utils/ResponseData.dart';

String uId = ResponseData.userId;
String apiurl = "http://10.0.2.2:8000/api/retrieveRequestedTours/";
String apiUrlforName =
    "http://10.0.2.2:8000/api/profileRetrieve/${ResponseData.userId}";
List data;
String profileImageUrl, name, ongoing;

class RequestedTripsCells extends StatefulWidget {
  @override
  _RequestedTripsCellsState createState() => _RequestedTripsCellsState();
}

class _RequestedTripsCellsState extends State<RequestedTripsCells> {
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
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
        _cell()
      ],
    ));
  }

  Widget _cell() {
    return data != null && data.length != null && data.length > 0
        ? ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (context, index) {
              return SimpleFoldingCell(
                  frontWidget: _buildFrontWidget(index),
                  innerTopWidget: _buildInnerTopWidget(index),
                  innerBottomWidget: _card1(index),
                  cellSize: Size(MediaQuery.of(context).size.width, 200),
                  padding: EdgeInsets.all(15),
                  animationDuration: Duration(milliseconds: 300),
                  borderRadius: 10,
                  onOpen: () => print('$index cell opened'),
                  onClose: () => print('$index cell closed'));
            })
        : Container();
  }

  Widget _buildFrontWidget(int index) {
    return Builder(
      builder: (BuildContext context) {
        return Container(
            color: Colors.black,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("${data[index]["place"]} -Requested",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'OpenSans',
                        fontSize: 20.0,
                        fontWeight: FontWeight.w800)),
                SizedBox(
                  height: 10,
                ),
                FlatButton(
                  onPressed: () {
                    SimpleFoldingCellState foldingCellState =
                        context.ancestorStateOfType(
                            TypeMatcher<SimpleFoldingCellState>());
                    foldingCellState?.toggleFold();
                  },
                  child: Text(
                    "View",
                  ),
                  textColor: Colors.white,
                  color: Colors.indigoAccent,
                  splashColor: Colors.white.withOpacity(0.5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                )
              ],
            ));
      },
    );
  }

  Widget _buildInnerTopWidget(int index) {
    return Container(
        color: Colors.teal,
        alignment: Alignment.center,
        child: Container(
          color: Colors.teal,
          child: Column(
            children: <Widget>[
              Card(
                child: ListTile(
                    leading: Text("Tour type",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    trailing: Text(data[index]['tour_type'],
                        style: TextStyle(fontWeight: FontWeight.bold))),
              ),
              Card(
                child: ListTile(
                    leading: Text(
                      "Place:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: Text(
                      data[index]["place"],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
              ),
              Card(
                child: ListTile(
                    leading: Text(
                      "Date :",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: Text(
                      data[index]["date"],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
              ),
            ],
          ),
        ));
  }

  Widget _card1(int index) {
    return Builder(builder: (context) {
      return SingleChildScrollView(
        child: ExpandableNotifier(
          child: ScrollOnExpand(
            scrollOnExpand: true,
            scrollOnCollapse: true,
            child: Container(
              color: Colors.teal,
              child: Column(
                children: <Widget>[
                  ScrollOnExpand(
                    scrollOnExpand: true,
                    scrollOnCollapse: false,
                    child: ExpandablePanel(
                      tapHeaderToExpand: true,
                      tapBodyToCollapse: true,
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      header: Padding(
                        padding: EdgeInsets.all(10),
                      ),
                      collapsed: RaisedButton(
                        onPressed: () {
                          data[index]['id'] = ResponseData.onGoingTripId;
                          print(data[index]['id']);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Chatroom()));
                        },
                        child: Text("Start Trip"),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        color: Colors.white,
                      ),
                      expanded: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            child: Column(
                              children: <Widget>[
                                Card(
                                  child: ListTile(
                                    leading: Text(
                                      "Days :",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(left: 70),
                                    ),
                                    CircleAvatar(),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                    ),
                                    Text(
                                      "Sandun sameera",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                    ),
                                    StarRating(
                                      color: Colors.yellow,
                                      rating: 4,
                                      size: 15,
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: RaisedButton(
                                    onPressed: () {
                                      ResponseData.onGoingTripId = (data[index]['id']);
                                      print(data[index]['id']);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Chatroom()));
                                    },
                                    child: Text("Start trip"),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      builder: (_, collapsed, expanded) {
                        return Padding(
                          padding:
                              EdgeInsets.only(left: 10, right: 10, bottom: 10),
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
          ),
        ),
      );
    });
  }
}
