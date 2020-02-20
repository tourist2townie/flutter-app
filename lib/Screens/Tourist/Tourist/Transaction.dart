// import 'package:easy_web_view/easy_web_view.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:tt/utils/ResponseData.dart';
import 'package:url_launcher/url_launcher.dart';

String apiUrl = "http://10.0.2.2:8000/api/guideRating/${ResponseData.onGoingTripId}";

class Transaction extends StatefulWidget {
  @override
  _TransactionState createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {

  _launchURL() async {
    launch("https://sandbox.payhere.lk/pay/of5817742");
}
  var feedbackText = "Could be better";
  var sliderValue = 0.0;

  IconData feedbackIcon = Icons.sentiment_very_dissatisfied;
  Color feedbackColor = Colors.red;

   void guideRating() {
    http.put(apiUrl, headers: {
      'Accept': 'application/json',
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjliNTg2MWVlNTg0ZGJkZGI5MDc1NDc3YTQ1ZDQ3ZDM5NGNiMzU2ZGIxZjBhMjUwZDUyZjk0YmViNGQwOTM3NTI0ZTM0MGNhMzBiYWM5NDAwIn0.eyJhdWQiOiIxIiwianRpIjoiOWI1ODYxZWU1ODRkYmRkYjkwNzU0NzdhNDVkNDdkMzk0Y2IzNTZkYjFmMGEyNTBkNTJmOTRiZWI0ZDA5Mzc1MjRlMzQwY2EzMGJhYzk0MDAiLCJpYXQiOjE1NTg1NTMyMTMsIm5iZiI6MTU1ODU1MzIxMywiZXhwIjoxNTkwMTc1NjEzLCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.sFIfXVx72efT54J40TVkqh3rwMGW-anTulNMDnVvGh_eO_qz0oKRl56JYCBwPQchc7fTbG5ZkVwaf_oU85rzjq3hrgXaOIzOoaNYsAKTOpPVbPi26bqpMLCWFe26hZO3BmS_kCSSD_-WlYVOlEw5oXQt1_MHV1eBt0tbXFLkgNwvkFr9IOvySINVsDOVoCArvp2Cx-XYthIP-0JuC7yQny5byMKerRGDO8pIjKLnPTTi9YWo36KU1SlzqoK-IJrQFvi5ir-rKk93IFCXwNoRN9QwXATb_4uJJyhpv2WLtXQwpnlPFqQFad8L0I8y9pfyzXnDtl3Aq1G3OlZMHbKcXp4uV8uByuT7UzI_FW6a0ion3Id1P3wy65n-X2OW2rDH6cpoCaz5_yzkpUfeo5WQ0RpG7q_VbWon2rf2NpbV8Jyzg80Woz3eNaQPA8-hdR5qUeeGXXulwfcT_sQln2uBmC3Ke2gbI1cKrBa4gVFpip9055lhgXfKzBvNkhV2dUljawBGacb0p4C1irkz6ygTzMu_31r2KHuzXiKQvbaEmorHGOLdvrwr-L2cqUmM3_jeAMmrV2_Pe4nRJHsvOLOYpB6ELNdeX8_DhD7DWUa6pdeU2PpRsXvwaGLbAkah9z7hCa54HGCzSLJPhN813nTXHuK_biSxIlH5n3ruvHiP6Rw'
    }, body: {
      "guide_rating": sliderValue.toString(),
    }).then((response) {
      if (response.statusCode == 200) {
        print('Response status : ${response.statusCode}');
        Fluttertoast.showToast(
          msg: "Guide successfully rated"
        );
      } else {
        print(apiUrl);
        print('Response body : ${response.statusCode}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Feedback"),
        backgroundColor: Colors.teal,
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.teal,
        label: Text("Pay here"),
        icon: Icon(Icons.payment),
        onPressed: () {
          _launchURL();
        },
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.orangeAccent.withOpacity(0.3)),
        child: Center(
            child: Card(
          elevation: 10.0,
          margin: EdgeInsets.all(20.0),
          child: Container(
            decoration: BoxDecoration(color: Colors.teal.withOpacity(0.2)),
            height: 450.0,
            width: 600.0,
            child: Column(
              children: <Widget>[
                Center(
                  child: Card(
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 50.0),
                          ),
                          Text(
                            feedbackText,
                            style:
                                TextStyle(color: Colors.black, fontSize: 22.0),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20.0),
                          ),
                          Container(
                            child: Icon(
                              feedbackIcon,
                              color: feedbackColor,
                              size: 100.0,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                          ),
                          Container(
                            child: Slider(
                              divisions: 5,
                              min: 0.0,
                              max: 5.0,
                              value: sliderValue,
                              activeColor: Colors.red,
                              inactiveColor: Colors.blue,
                              onChanged: (newValue) {
                                setState(() {
                                  sliderValue = newValue;
                                  if (sliderValue >= 0.0 &&
                                      sliderValue <= 1.0) {
                                    feedbackIcon =
                                        Icons.sentiment_very_dissatisfied;
                                    feedbackColor = Colors.red;
                                    feedbackText = "Could be better";
                                  }
                                  if (sliderValue >= 1.1 &&
                                      sliderValue <= 2.0) {
                                    feedbackIcon = Icons.sentiment_dissatisfied;
                                    feedbackColor = Colors.orange;
                                    feedbackText = "Below the average";
                                  }
                                  if (sliderValue >= 2.1 &&
                                      sliderValue <= 3.0) {
                                    feedbackIcon = Icons.sentiment_neutral;
                                    feedbackColor = Colors.brown;
                                    feedbackText = "Pretty much ok";
                                  }
                                  if (sliderValue >= 3.1 &&
                                      sliderValue <= 4.0) {
                                    feedbackIcon = Icons.sentiment_satisfied;
                                    feedbackColor = Colors.green;
                                    feedbackText = "Good job";
                                  }
                                  if (sliderValue >= 4.1 &&
                                      sliderValue <= 5.0) {
                                    feedbackIcon =
                                        Icons.sentiment_very_satisfied;
                                    feedbackColor = Colors.blue;
                                    feedbackText = "Awesome job keep it up";
                                  }
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(16.0),
                          ),
                          Container(
                            child: Text(
                              "Rating: $sliderValue",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(20.0),
                          ),
                          Container(
                            child: RaisedButton(
                              color: Colors.amber,
                              child: Text("Submit feedback"),
                              onPressed: () {
                                guideRating();
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 36,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
