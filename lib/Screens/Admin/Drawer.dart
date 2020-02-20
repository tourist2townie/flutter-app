import 'package:flutter/material.dart';
import 'package:tt/Screens/Admin/InquiryMgt.dart';
import 'package:tt/Screens/Admin/PackageManagement.dart';
import 'package:tt/Screens/Admin/Payments.dart';
import 'package:tt/Screens/Admin/PendingGuides.dart';


class AdminDrawer extends StatefulWidget {
  @override
  _AdminDrawerState createState() => _AdminDrawerState();
}

class _AdminDrawerState extends State<AdminDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: _drawerBody(),
    );
  }

  Widget _drawerBody(){
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.indigo,
            height: 200,
            child: Center(
              child: Text("Admin dashboard",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),),
            ),
          ),
         Card(
           color: Colors.indigo,
           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
           child:  ListTile(
            title: Text("Packages management",style: TextStyle(color: Colors.white),),
            onTap: (){
              Navigator.push(context,MaterialPageRoute(
                builder: (context)=>PackageManagement()
              ));
            },
          ),
         ),
          Card(
           color: Colors.indigo,
           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
           child:  ListTile(
            title: Text("Inquiry management",style: TextStyle(color: Colors.white),),
            onTap: (){
              Navigator.push(context,MaterialPageRoute(
                builder: (context)=>Inquirymanagement()
              ));
            },
          ),
         ),
          Card(
           color: Colors.indigo,
           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
           child:  ListTile(
            title: Text("Payment management",style: TextStyle(color: Colors.white),),
            onTap: (){
              Navigator.push(context,MaterialPageRoute(
                builder: (context)=>payments()
              ));
            },
          ),
         ),
          Card(
           color: Colors.indigo,
           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
           child:  ListTile(
            title: Text("Pending guides",style: TextStyle(color: Colors.white),),
            onTap: (){
              Navigator.push(context,MaterialPageRoute(
                builder: (context)=>PendingGuides()
              ));
            },
          ),
         ),
          //  ListTile(
          //   title: Text("Trip analyze"),
          //   onTap: (){
          //    Navigator.push(context,MaterialPageRoute(builder: (context)=>TripAnalyze()));
          //   },
          // )
        ],
      ),
    );
  }
}