import 'package:flutter/material.dart';

class Transaction extends StatefulWidget {
  @override
  _TransactionState createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  var feedbackText = "Could be better";
  var sliderValue = 0.0;

  IconData feedbackIcon = Icons.sentiment_very_dissatisfied;
  Color feedbackColor = Colors.red;

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
          print('Payment');
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
                              onPressed: () {},
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
