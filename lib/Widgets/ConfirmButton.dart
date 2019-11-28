import 'package:flutter/material.dart';
import 'package:tt/Screens/Tourist/Tourist/Transaction.dart';

class ConfirmButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
                  height: 50.0,
                  minWidth: 300.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)
                  ),
                  child: RaisedButton(
                    color: Colors.teal,
                    child: Text("Complete Trip",style: TextStyle(color: Colors.white),),
                    onPressed: (){
                      // OngoingTrip.completeTrip(context);
                      Navigator.push(context,MaterialPageRoute(
                      builder: (context)=>Transaction(),
                    ));
                    }),
                );
  }
}