import 'package:flutter/material.dart';

class MenuGuide {
  String title;
  IconData icon;
  String image;
  String items;
  MaterialPageRoute route;
  BuildContext context;
  Color menuColor;

  MenuGuide(
      {this.title,
        this.icon,
        this.image,
        this.route,
        this.items,
        this.context,
        this.menuColor = Colors.black});
}