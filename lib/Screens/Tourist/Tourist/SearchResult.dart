import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tt/utils/ResponseData.dart';

import 'GuideProfile.dart';
import 'ReportGuide.dart';

List data;

class SearchResult extends StatefulWidget {
  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  String apiurl =
      "http://10.0.2.2:8000/api/retrievePlaces/${ResponseData.searchQuery}";
  void searchedData(BuildContext context) async {
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
  void initState() {
    this.searchedData(context);
    super.initState();
    print(apiurl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ResponseData.searchQuery),
      ),
      body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/guide_search.jpg"),
                    fit: BoxFit.cover)),
            child: showGuides()),
    );
  }

  Widget showGuides() {
    return data != null && data.length != null && data.length > 0
        ? ListView.builder(
            itemCount: data.length == null ? 0 : data.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(4.0),
                      ),
                      Card(
                        color: Colors.transparent,
                        semanticContainer: true,
                        child: ListTile(
                          selected: false,
                          onLongPress: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ReportGuide()));
                          },
                          leading: CircleAvatar(
                            minRadius: 3.0,
                            maxRadius: 25.0,
                            backgroundImage:
                                AssetImage("assets/images/circle_avatar.jpg"),
                          ),
                          title: Text(
                            data[index]['guide_name'],
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.0),
                          ),
                          trailing: Text(
                            "3.2",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.0),
                          ),
                          onTap: () {
                            ResponseData.searchedGuide = data[index]['guide_id'].toString();
                            print(ResponseData.searchedGuide);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GuideProfileTourist()),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            })
        : Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }
}
