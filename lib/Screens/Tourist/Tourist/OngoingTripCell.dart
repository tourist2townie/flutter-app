import 'dart:convert';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:folding_cell/folding_cell/widget.dart';
import 'package:toast/toast.dart';
import 'package:tt/Screens/Tourist/Tourist/JoinTrip.dart';
import 'package:tt/Screens/Tourist/Tourist/RequestedTrips.dart' as prefix1;
import 'package:tt/Screens/Tourist/Tourist/TouristProfile.dart';
import 'package:tt/Screens/Tourist/Tourist/Transaction.dart' as prefix0;
import 'package:tt/utils/ResponseData.dart';
import 'package:http/http.dart' as http;

List data, requestedData;
var convertJasonToData;
String tourtype, place, days, date, profileImageUrl;
String ongoing;

String apiurl2 = 'http://10.0.2.2:8000/api/retrieveOngoingTrip/';
String apiUrlforName =
    "http://10.0.2.2:8000/api/profileRetrieve/${ResponseData.userId}";

class OngoingTripCell extends StatefulWidget {
  @override
  _OngoingTripState createState() => _OngoingTripState();
}

class _OngoingTripState extends State<OngoingTripCell> {
  @override
  void initState() {
    this.loadProfile(context);
    this.onGoingTrip(context);
    print(ResponseData.userId);
    super.initState();
  }

  void loadProfile(BuildContext context) async {
    var response = await http.get(Uri.encodeFull(apiUrlforName),
        headers: {"Accept": "application/json"});

    if (this.mounted) {
      var convertJasonToDataname = json.decode(response.body);
      setState(() {
        name = convertJasonToDataname["name"];
        profileImageUrl = convertJasonToDataname["profile_image"];
      });
    }
  }

  void onGoingTrip(BuildContext context) async {
    print(apiUrl);
    var response = await http
        .get(Uri.encodeFull(apiurl2), headers: {"Accept": "application/json"});
    convertJasonToData = json.decode(response.body);
    if (convertJasonToData != null) {
      if (convertJasonToData['status'] == "Ongoing" ||
          convertJasonToData['status'] == null) {
        print("sdnlk");
      } else
        print(apiurl2);
    } else {}

    if (this.mounted) {
      setState(() {
        ongoing = convertJasonToData["id"].toString();
        tourtype = convertJasonToData['tour_type'];
        place = convertJasonToData['place'];
        days = convertJasonToData['No_of_days'].toString();
        date = convertJasonToData['date'].toString();
      });
    }
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
      body: _mainBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => JoinTrip()));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _mainBody() {
    return Container(
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            _profileName(),
            SafeArea(
              child: Tripscells(),
            ),
            SafeArea(
              child: prefix1.RequestedTripsCells(),
            ),
          ],
        ));
  }

  Widget _profileName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 0.1),
        ),
        InkWell(
          child: Container(
            child: Text(
              name != null ? name : "Loading",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                  fontSize: 30),
            ),
          ),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => TouristProfile()));
          },
        ),
        CircleAvatar(
          radius: 40,
          child: ClipOval(
            child: Image.network(
              profileImageUrl != null ? profileImageUrl : "",
              fit: BoxFit.cover,
              height: 150,
              width: 100,
            ),
          ),
        ),
      ],
    );
  }
}

class Tripscells extends StatefulWidget {
  @override
  _TripscellsState createState() => _TripscellsState();
}

class _TripscellsState extends State<Tripscells> {
  final _foldingCellKey = GlobalKey<SimpleFoldingCellState>();

  void onGoingTrip(BuildContext context) async {
    print(apiUrl);
    var response = await http
        .get(Uri.encodeFull(apiurl2), headers: {"Accept": "application/json"});
    convertJasonToData = json.decode(response.body);
    if (convertJasonToData != null) {
      if (convertJasonToData['status'] == "Ongoing" ||
          convertJasonToData['status'] == null) {
        print("sdnlk");
      } else
        print(apiurl2);
    } else {}
  }

  void editTriptatus() {
    String apiUrl = "http://10.0.2.2:8000/api/tripStatusUpdate/$ongoing";
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
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => prefix0.Transaction()));
      } else {
        print('Response body : ${response.body}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return convertJasonToData != null
        ? Container(
            child: Column(
              children: <Widget>[
                // myClipPath(),

                SimpleFoldingCell(
                    key: _foldingCellKey,
                    frontWidget: _buildFrontWidget(),
                    innerTopWidget: _buildInnerTopWidget(),
                    innerBottomWidget: _card1(),
                    cellSize: Size(MediaQuery.of(context).size.width, 210),
                    padding: EdgeInsets.all(15),
                    animationDuration: Duration(milliseconds: 300),
                    borderRadius: 10,
                    onOpen: () => print('cell opened'),
                    onClose: () => print('cell closed')),
              ],
            ),
          )
        : Container();
  }

  Widget _buildFrontWidget() {
    return Container(
        color: Colors.grey[600],
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Ongoing",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'OpenSans',
                    fontSize: 20.0,
                    fontWeight: FontWeight.w800)),
            Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            FlatButton(
              onPressed: () => _foldingCellKey?.currentState?.toggleFold(),
              child: Text(
                "View",
              ),
              textColor: Colors.white,
              color: Colors.indigoAccent,
              splashColor: Colors.white.withOpacity(0.5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            )
          ],
        ));
  }

  Widget _buildInnerTopWidget() {
    return Container(
        color: Colors.teal,
        alignment: Alignment.center,
        child: Card(
          color: Colors.teal,
          child: Column(
            children: <Widget>[
              Card(
                child: ListTile(
                    leading: Text(
                      "Tour type :",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: Text(
                        tourtype == null ? "No Ongoing trips" : tourtype,
                        style: TextStyle(fontWeight: FontWeight.bold))),
              ),
              Card(
                child: ListTile(
                    leading: Text(
                      "Place:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: Text(
                      place == null ? "No Ongoing trips" : place,
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
                      date == null ? "No ongoing trips" : date,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
              )
            ],
          ),
        ));
  }

  Widget _card1() {
    return SingleChildScrollView(
      child: ExpandableNotifier(
        child: ScrollOnExpand(
          scrollOnExpand: false,
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
                      padding: EdgeInsets.all(8),
                    ),
                    collapsed: RaisedButton(
                      onPressed: () {
                        editTriptatus();
                        onGoingTrip(context);
                      },
                      child: Text("Complete Trip"),
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
                                    trailing: Text(
                                      days == null ? "No ongoing trips" : date,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                                    onGoingTrip(context);
                                    editTriptatus();
                                  },
                                  child: Text("Complete trip"),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0)),
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: 5,
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
  }
}
