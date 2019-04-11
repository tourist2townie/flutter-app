import 'package:flutter/material.dart';

class power extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User page'),
      ),
      body: Column(
        children: <Widget>[
          Text ("Im a admin"),
        ],
      ),
    );
  }

}