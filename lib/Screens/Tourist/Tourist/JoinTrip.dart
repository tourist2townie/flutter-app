import 'package:flutter/material.dart';
import 'package:page_view_indicator/page_view_indicator.dart';

class JoinTrip extends StatelessWidget {
  static const length = 4;
  final pageIndexNotifier = ValueNotifier<int>(0);
  List<Widget> TypesOfTripList = new List();

  JoinTrip();

  @override
  Widget build(BuildContext context) {
    TypesOfTripList.add(Adventure());
    TypesOfTripList.add(SightSeeing());
    TypesOfTripList.add(FuckA());
    TypesOfTripList.add(FuckB());

    return Scaffold(
      body: Container(
        color: Color(0xFFDCDCDC),
        child: Column(
          children: <Widget>[
            Container(
              height: 400.0,
              child: Stack(
                fit: StackFit.loose,
                alignment: FractionalOffset.bottomCenter,
                children: <Widget>[
                  PageView.builder(
                    onPageChanged: (index) => pageIndexNotifier.value = index,
                    itemCount: length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(),
                      );
                    },
                  ),
                  _buildExample1()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  PageViewIndicator  _buildExample1() {
    return PageViewIndicator(
      pageIndexNotifier: pageIndexNotifier,
      length: length,
      normalBuilder: (animationController) => Circle(
            size: 8.0,
            color: Colors.black87,
          ),
      highlightedBuilder: (animationController) => ScaleTransition(
            scale: CurvedAnimation(
              parent: animationController,
              curve: Curves.ease,
            ),
            child: Circle(
              size: 12.0,
              color: Colors.black45,
            ),
          ),
    );
  }
}


//-------------------------------------------------------------------------------------------------------------------------------
// Types of trips
// ----------------------------------------------------------------------------------------------------------------------
class Adventure extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return null;
  }
}

class SightSeeing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("ldfjd");
  }
}

class FuckA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("fbh");
  }
}

class FuckB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("fj");
  }
}




