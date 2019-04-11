import 'package:flutter/material.dart';
import 'package:tt/models/model.dart';
import 'package:tt/utils/uidata.dart';

class MenuViewModelGuide {
  List<Menu> menuItemsGuide;

  MenuViewModelGuide({this.menuItemsGuide});

  getMenuItems() {
    return menuItemsGuide = <Menu>[
      Menu(
          title: "Profile",
          menuColor: Color(0xff050505),
          icon: Icons.person,
          image: UIData.profileImage,
          items:"GuideProfile"
      ),
      Menu(
          title: "Confirm Requests",
          menuColor: Color(0xffc8c4bd),
          icon: Icons.assignment_turned_in,
          image: UIData.shoppingImage,
          items:""
      ),
      Menu(
          title: "Contact Admin",
          menuColor: Color(0xffc7d8f4),
          icon: Icons.contact_phone,
          image: UIData.contactAdmin,
          items:"GuideProfile"
      ),
      Menu(
          title: "Notifications",
          menuColor: Color(0xff7f5741),
          icon: Icons.notification_important,
          image: UIData.timelineImage,
          items:"GuideProfile"
      ),
      Menu(
          title: "Dashboard",
          menuColor: Color(0xff261d33),
          icon: Icons.dashboard,
          image: UIData.photos,
          items:"JoinTrip"
      ),
      Menu(
          title: "Settings",
          menuColor: Color(0xff2a8ccf),
          icon: Icons.settings,
          image: UIData.settingsImage,
          items:"GuideProfile"
      ),
      Menu(
          title: "Photos",
          menuColor: Color(0xffe19b6b),
          icon: Icons.photo,
          image: UIData.blankImage,
          items:"GuideProfile"
      ),
      Menu(
          title: "Payment History",
          menuColor: Color(0xffddcec2),
          icon: Icons.payment,
          image: UIData.paymentImage,
          items:"GuideProfile"
      ),
    ];
  }
}
