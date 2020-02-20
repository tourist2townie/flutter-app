import 'dart:convert';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'package:tt/utils/ResponseData.dart';

import 'TouristProfileGuide.dart';

String apiurl = "http://10.0.2.2:8000/api/getPendingPackages";
String assignmeapiurl = "http://10.0.2.2:8000/api/assignPackages/5";
List data;

class NewPackages extends StatefulWidget {
  @override
  _NewPackagesState createState() => _NewPackagesState();
}

class _NewPackagesState extends State<NewPackages> {
  void getPendingPackages(BuildContext context) async {
    var response = await http
        .get(Uri.encodeFull(apiurl), headers: {"Accept": "application/json"});

    if (this.mounted) {
      setState(() {
        var convertJsonToData = json.decode(response.body);
        data = convertJsonToData;
      });
    }
  }

  void occupyTrip() {
    http.put(assignmeapiurl, headers: {
      'Accept': 'application/json',
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjliNTg2MWVlNTg0ZGJkZGI5MDc1NDc3YTQ1ZDQ3ZDM5NGNiMzU2ZGIxZjBhMjUwZDUyZjk0YmViNGQwOTM3NTI0ZTM0MGNhMzBiYWM5NDAwIn0.eyJhdWQiOiIxIiwianRpIjoiOWI1ODYxZWU1ODRkYmRkYjkwNzU0NzdhNDVkNDdkMzk0Y2IzNTZkYjFmMGEyNTBkNTJmOTRiZWI0ZDA5Mzc1MjRlMzQwY2EzMGJhYzk0MDAiLCJpYXQiOjE1NTg1NTMyMTMsIm5iZiI6MTU1ODU1MzIxMywiZXhwIjoxNTkwMTc1NjEzLCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.sFIfXVx72efT54J40TVkqh3rwMGW-anTulNMDnVvGh_eO_qz0oKRl56JYCBwPQchc7fTbG5ZkVwaf_oU85rzjq3hrgXaOIzOoaNYsAKTOpPVbPi26bqpMLCWFe26hZO3BmS_kCSSD_-WlYVOlEw5oXQt1_MHV1eBt0tbXFLkgNwvkFr9IOvySINVsDOVoCArvp2Cx-XYthIP-0JuC7yQny5byMKerRGDO8pIjKLnPTTi9YWo36KU1SlzqoK-IJrQFvi5ir-rKk93IFCXwNoRN9QwXATb_4uJJyhpv2WLtXQwpnlPFqQFad8L0I8y9pfyzXnDtl3Aq1G3OlZMHbKcXp4uV8uByuT7UzI_FW6a0ion3Id1P3wy65n-X2OW2rDH6cpoCaz5_yzkpUfeo5WQ0RpG7q_VbWon2rf2NpbV8Jyzg80Woz3eNaQPA8-hdR5qUeeGXXulwfcT_sQln2uBmC3Ke2gbI1cKrBa4gVFpip9055lhgXfKzBvNkhV2dUljawBGacb0p4C1irkz6ygTzMu_31r2KHuzXiKQvbaEmorHGOLdvrwr-L2cqUmM3_jeAMmrV2_Pe4nRJHsvOLOYpB6ELNdeX8_DhD7DWUa6pdeU2PpRsXvwaGLbAkah9z7hCa54HGCzSLJPhN813nTXHuK_biSxIlH5n3ruvHiP6Rw'
    }, body: {
      "status": "Occupied",
      "guide_id": ResponseData.userId,
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
  void initState() {
    this.getPendingPackages(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _packagesList(),
    );
  }

  Widget _packagesList() {
    return data != null && data.length != null && data.length > 0
        ? ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return ExpandableNotifier(
                  child: ScrollOnExpand(
                scrollOnExpand: false,
                scrollOnCollapse: true,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 150,
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/pidurangala.jpg"),
                                  fit: BoxFit.cover),
                              shape: BoxShape.rectangle,
                            ),
                          ),
                        ),
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
                                style: Theme.of(context).textTheme.body2,
                              )),
                            ),
                            collapsed: RaisedButton(
                              onPressed: () {
                                occupyTrip();
                              },
                              child: Text("Assign me"),
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
                                      InkWell(
                                        onTap: () {
                                          ResponseData.searchedTourist =
                                              data[index]['tourist_id']
                                                  .toString();
                                          ResponseData.searchedTourist != null
                                              ? Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          TouristProfileGuide()))
                                              : Toast.show(
                                                  "Tourist not assigned yet",
                                                  context);
                                          print(ResponseData.searchedTourist);
                                        },
                                        child: Card(
                                          child: ListTile(
                                            leading: Text("Name of customer"),
                                            trailing: Text(data[index]
                                                    ['tourist_id']
                                                .toString()),
                                          ),
                                        ),
                                      ),
                                      Card(
                                        child: ListTile(
                                          leading: Text("Date"),
                                          trailing: Text(data[index]['date']),
                                        ),
                                      ),
                                      Card(
                                        child: ListTile(
                                          leading: Text("No of days"),
                                          trailing: Text(
                                              data[index]['days'].toString()),
                                        ),
                                      ),
                                      Card(
                                        child: ListTile(
                                          leading: Text("province"),
                                          trailing: Text(data[index]['province']
                                              .toString()),
                                        ),
                                      ),
                                      RaisedButton(
                                        onPressed: () {
                                          occupyTrip();
                                        },
                                        child: Text("Assign me"),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0)),
                                        color: Colors.teal,
                                      ),
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
                ),
              ));
            },
          )
        : Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }
}
