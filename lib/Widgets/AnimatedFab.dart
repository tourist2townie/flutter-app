import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:tt/Screens/Tourist/Tourist/OngoingTrip.dart';
import 'package:tt/Screens/Tourist/Tourist/TripStatus.dart';

class AnimatedFab extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return SpeedDial(
        backgroundColor: Colors.teal,
          animatedIcon:AnimatedIcons.menu_close,
        children: [
          SpeedDialChild(
            backgroundColor: Colors.redAccent,
            child: Icon(Icons.directions_bike),
            label: "All Trips",
            onTap: ()=>Navigator.push(context,MaterialPageRoute(
              builder: (context)=>TripStatus(),
            )),
          ),
          SpeedDialChild(
            backgroundColor: Colors.brown,
            child: Icon(Icons.directions_run),
            label: "Ongoing Trip",
            onTap: ()=>Navigator.push(context,MaterialPageRoute(
              builder: (context)=>OngoingTrip(),
            ))
          ),
          SpeedDialChild(
            backgroundColor: Colors.brown,
            child: Icon(Icons.panorama_fish_eye),
            label: "Requested trips",
            // onTap: ()=>Navigator.push(context,MaterialPageRoute(
            //   builder: (context)=>RequestedTrips(),
            // ))
          ),
        ],
    );
      
  }

}