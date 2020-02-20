import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:tt/utils/ResponseData.dart';

String apiurl = "http://10.0.2.2:8000/api/getNewGuides/";
List data;
//var convertJsonToData;
var length;

class PendingGuides extends StatefulWidget {

  @override
  _PendingGuidesState createState() => _PendingGuidesState();
}

class _PendingGuidesState extends State<PendingGuides> {
  static String idx;
  @override
  void initState() {
    super.initState();
    this.getInq(context);
  
 //   print(convertJsonToData);
  }

  void getInq(BuildContext context) async {
    var response = await http
        .get(Uri.encodeFull(apiurl), headers: {"Accept": "application/json"});

    if (this.mounted) {
      setState(() {
        var convertJsonToData = json.decode(response.body);
        data = convertJsonToData;
        length = convertJsonToData.length;
        print(convertJsonToData);
      });
    }
  }

 
  static void editData() {
    String confirmGuideUrl = "http://10.0.2.2:8000/api/guideStatusUpdate/${ResponseData.acceptGuide}";
    http.put(confirmGuideUrl, headers: {
      'Accept': 'application/json',
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjliNTg2MWVlNTg0ZGJkZGI5MDc1NDc3YTQ1ZDQ3ZDM5NGNiMzU2ZGIxZjBhMjUwZDUyZjk0YmViNGQwOTM3NTI0ZTM0MGNhMzBiYWM5NDAwIn0.eyJhdWQiOiIxIiwianRpIjoiOWI1ODYxZWU1ODRkYmRkYjkwNzU0NzdhNDVkNDdkMzk0Y2IzNTZkYjFmMGEyNTBkNTJmOTRiZWI0ZDA5Mzc1MjRlMzQwY2EzMGJhYzk0MDAiLCJpYXQiOjE1NTg1NTMyMTMsIm5iZiI6MTU1ODU1MzIxMywiZXhwIjoxNTkwMTc1NjEzLCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.sFIfXVx72efT54J40TVkqh3rwMGW-anTulNMDnVvGh_eO_qz0oKRl56JYCBwPQchc7fTbG5ZkVwaf_oU85rzjq3hrgXaOIzOoaNYsAKTOpPVbPi26bqpMLCWFe26hZO3BmS_kCSSD_-WlYVOlEw5oXQt1_MHV1eBt0tbXFLkgNwvkFr9IOvySINVsDOVoCArvp2Cx-XYthIP-0JuC7yQny5byMKerRGDO8pIjKLnPTTi9YWo36KU1SlzqoK-IJrQFvi5ir-rKk93IFCXwNoRN9QwXATb_4uJJyhpv2WLtXQwpnlPFqQFad8L0I8y9pfyzXnDtl3Aq1G3OlZMHbKcXp4uV8uByuT7UzI_FW6a0ion3Id1P3wy65n-X2OW2rDH6cpoCaz5_yzkpUfeo5WQ0RpG7q_VbWon2rf2NpbV8Jyzg80Woz3eNaQPA8-hdR5qUeeGXXulwfcT_sQln2uBmC3Ke2gbI1cKrBa4gVFpip9055lhgXfKzBvNkhV2dUljawBGacb0p4C1irkz6ygTzMu_31r2KHuzXiKQvbaEmorHGOLdvrwr-L2cqUmM3_jeAMmrV2_Pe4nRJHsvOLOYpB6ELNdeX8_DhD7DWUa6pdeU2PpRsXvwaGLbAkah9z7hCa54HGCzSLJPhN813nTXHuK_biSxIlH5n3ruvHiP6Rw'
    }, body: {
      "status": 'Accepted',
    }).then((response) {
      if (response.statusCode == 200) {
       Fluttertoast.showToast(msg: "Successfully Accepted");
      } else {
        print(confirmGuideUrl);
        print('Response status : ${response.statusCode}');
        print('Response body : ${response.body}');
      }
    });
  }

  static void deleteRequest() {
    String deleteURL = "http://10.0.2.2:8000/api/removeuser/${ResponseData.searchedGuide}";
    http.delete(deleteURL, headers: {
      'Accept': 'application/json',
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjliNTg2MWVlNTg0ZGJkZGI5MDc1NDc3YTQ1ZDQ3ZDM5NGNiMzU2ZGIxZjBhMjUwZDUyZjk0YmViNGQwOTM3NTI0ZTM0MGNhMzBiYWM5NDAwIn0.eyJhdWQiOiIxIiwianRpIjoiOWI1ODYxZWU1ODRkYmRkYjkwNzU0NzdhNDVkNDdkMzk0Y2IzNTZkYjFmMGEyNTBkNTJmOTRiZWI0ZDA5Mzc1MjRlMzQwY2EzMGJhYzk0MDAiLCJpYXQiOjE1NTg1NTMyMTMsIm5iZiI6MTU1ODU1MzIxMywiZXhwIjoxNTkwMTc1NjEzLCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.sFIfXVx72efT54J40TVkqh3rwMGW-anTulNMDnVvGh_eO_qz0oKRl56JYCBwPQchc7fTbG5ZkVwaf_oU85rzjq3hrgXaOIzOoaNYsAKTOpPVbPi26bqpMLCWFe26hZO3BmS_kCSSD_-WlYVOlEw5oXQt1_MHV1eBt0tbXFLkgNwvkFr9IOvySINVsDOVoCArvp2Cx-XYthIP-0JuC7yQny5byMKerRGDO8pIjKLnPTTi9YWo36KU1SlzqoK-IJrQFvi5ir-rKk93IFCXwNoRN9QwXATb_4uJJyhpv2WLtXQwpnlPFqQFad8L0I8y9pfyzXnDtl3Aq1G3OlZMHbKcXp4uV8uByuT7UzI_FW6a0ion3Id1P3wy65n-X2OW2rDH6cpoCaz5_yzkpUfeo5WQ0RpG7q_VbWon2rf2NpbV8Jyzg80Woz3eNaQPA8-hdR5qUeeGXXulwfcT_sQln2uBmC3Ke2gbI1cKrBa4gVFpip9055lhgXfKzBvNkhV2dUljawBGacb0p4C1irkz6ygTzMu_31r2KHuzXiKQvbaEmorHGOLdvrwr-L2cqUmM3_jeAMmrV2_Pe4nRJHsvOLOYpB6ELNdeX8_DhD7DWUa6pdeU2PpRsXvwaGLbAkah9z7hCa54HGCzSLJPhN813nTXHuK_biSxIlH5n3ruvHiP6Rw'
    }).then((response) {
      if (response.statusCode == 200) {
        print("Successfully deleted");
      } else {
        print(response.statusCode);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Guide Requests"),
        backgroundColor: Colors.indigo,
      ),
      body: _guideList(),
    );
  }

  AlertDialog alert = AlertDialog(
    title: Text("Take action"),
    content: Text("You can accept this guide or remove"),
    actions: [
      FlatButton(
        onPressed: (){
          editData();
        },
        color: Colors.indigo,
        child: Text("Accept"),
      ),
      FlatButton(
        onPressed: (){
          deleteRequest();
        },
        color: Colors.indigo,
        child: Text("Decline"),
      ),
    ],
  );


  Widget _guideList() {
    return data != null && data.length != null && data.length > 0
        ? ListView.builder(
            itemCount:
                length == null ? 0 : length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  color: Colors.indigo,
                  child: ListTile(
                    title: Text(
                      data[index]["name"],
                      style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                    ),
                    onLongPress: (){
                      ResponseData.acceptGuide = data[index]['id'].toString();
                      showDialog(
                      context: context,
                      builder:(BuildContext context){
                        return alert;
                      });
                    },
                  ),
                ),
              );
            })
        : Container(
            child: Center(
              child: Text("No new guides"),
            ),
          );
  }
}