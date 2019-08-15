import 'package:flutter/material.dart';

class TouristPhotos extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    
    return TouristPhotosState();
      }
    
    }
    
    class TouristPhotosState extends State<TouristPhotos>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("photos"),
      ),
    );
  }
} 