import 'package:flutter/material.dart';

class Photos extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    
    return PhotosState();
      }
    
    }
    
    class PhotosState extends State<Photos>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("photos"),
      ),
    );
  }
} 