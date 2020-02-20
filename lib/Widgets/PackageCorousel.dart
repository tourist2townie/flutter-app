import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

class PackageCorousel extends StatefulWidget {
  @override
  _PackageCorouselState createState() => _PackageCorouselState();
}

class _PackageCorouselState extends State<PackageCorousel> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.0,
      width: 370.0,
      child: Carousel(
        boxFit: BoxFit.cover,
        autoplay: true,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(milliseconds: 1000),
        dotSize: 8.0,
        dotIncreasedColor: Colors.indigo,
        dotBgColor: Colors.transparent,
        dotPosition: DotPosition.bottomCenter,
        dotVerticalPadding: 10.0,
        showIndicator: true,
        indicatorBgPadding: 7.0,
        images: [
          AssetImage("assets/images/sigiriya.jpg"),
          AssetImage("assets/images/hist_bac.jpg"),
          AssetImage("assets/images/hike_bac.jpg"),
          AssetImage("assets/images/pidurangala.jpg"),
        ],
      ),
    );
  }
}