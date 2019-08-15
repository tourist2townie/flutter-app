import 'package:flutter/material.dart';
import 'package:tt/Screens/Tourist/Tourist/TouristProfile.dart';
import 'package:tt/models/model.dart';
import 'package:tt/utils/uidata.dart';

class MenuViewModel {
  List<Menu> menuItems;

  MenuViewModel({this.menuItems});

  getMenuItems() {
    return menuItems = <Menu>[
      Menu(
        title: "Profile",
        menuColor: Color(0xff050505),
        icon: Icons.person,
        
        image: UIData.profileImage,
        items:UIData.TouristProfile,
        route:MaterialPageRoute(builder: (context) => TouristProfile()),
      ),
      Menu(
        title: "Join Trip",
        menuColor: Color(0xffc8c4bd),
        icon: Icons.train,
        image: UIData.shoppingImage,
          items:UIData.JoinTrip,
      ),
      Menu(
        title: "Timeline",
        menuColor: Color(0xffc7d8f4),
        icon: Icons.timeline,
        image: UIData.contactAdmin,
          items:UIData.Timeline
      ),
      Menu(
        title: "Payments",
        menuColor: Color(0xff7f5741),
        icon: Icons.timeline,
        image: UIData.timelineImage,
          items:UIData.Payment
      ),
      Menu(
        title: "Photos",
        menuColor: Color(0xff261d33),
        icon: Icons.photo,
        image: UIData.photos,
          items:UIData.Photos
      ),
      Menu(
        title: "Settings",
        menuColor: Color(0xff2a8ccf),
        icon: Icons.settings,
        image: UIData.settingsImage,
          items:UIData.Settings,
      ),
    ];
  }
}
