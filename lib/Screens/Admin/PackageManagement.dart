import 'dart:convert';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tt/Screens/Admin/ComposePackage.dart';
import 'package:tt/Screens/Tourist/Tourist/GuideProfile.dart';
import 'package:tt/Widgets/PackageCorousel.dart';
import 'package:tt/utils/ResponseData.dart';

class PackageManagement extends StatefulWidget {
  @override
  _PackageManagementState createState() => _PackageManagementState();
}

class _PackageManagementState extends State<PackageManagement> {
  @override
  void initState() {
    super.initState();
    this.getAllPackages(context);
  }

  List data;
  String category, guidename, date, province, type,days;
  String apiurl = "http://10.0.2.2:8000/api/getAllPackages/";

  void getAllPackages(BuildContext ctx) async {
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          color: Colors.black,
          onPressed: ()=>Navigator.pop(context),
        ),
      ),
      body: _packageList(),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Compose package"),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(
            builder: (context)=>ComposePackage()
          ));
        },
        backgroundColor: Colors.indigo,
      ),
    );
  }

  Widget _packageList() {
    return data != null && data.length != null && data.length > 0
        ? ListView.builder(
            itemCount: data.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              type = data[index]["category"];
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
                                            ResponseData.searchedGuide = data[index]["guide_id"].toString();
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
                                          trailing: Text(data[index]["days"].toString()),
                                        ),
                                      ),
                                      Card(
                                        color: Colors.indigo.withOpacity(0.3),
                                        child: ListTile(
                                          leading: Text("Price",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold)),
                                          trailing: Text(data[index]["price"].toString()),
                                        ),
                                      ),
                                      Card(
                                        color: Colors.indigo.withOpacity(0.3),
                                        child: ListTile(
                                          leading: Text("status",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold)),
                                          trailing: Text(data[index]["status"]!=null?data[index]["status"]:"no packages"),
                                        ),
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
