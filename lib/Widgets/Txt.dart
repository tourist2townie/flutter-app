import 'package:flutter/material.dart';

class Txt extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final FontWeight fontWeight;

  Txt({this.text,this.textStyle,this.fontWeight});


  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: Colors.black,fontWeight: fontWeight),   
    );
  }
}