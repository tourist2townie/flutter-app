import 'package:flutter/material.dart';
import 'package:tt/models/ModelGuide.dart';
import 'package:tt/utils/uidata.dart';

class MenuViewModelGuide {
  List<MenuGuide> menuItemsGuide;

  MenuViewModelGuide({this.menuItemsGuide});

  getMenuItems() {
    return menuItemsGuide = <MenuGuide>[
      MenuGuide(
          title: "Profile",
          menuColor: Color(0xff050505),
          icon: Icons.person,
          image: UIData.profileImage,
          items:UIData.GuideProfile
      ),
      MenuGuide(
          title: "Confirm Requests",
          menuColor: Color(0xffc8c4bd),
          icon: Icons.assignment_turned_in,
          image: UIData.shoppingImage,
          items:UIData.ConfirmRequest
      ),
      MenuGuide(
          title: "Chat Room",
          menuColor: Color(0xffc7d8f4),
          icon: Icons.contact_phone,
          image: UIData.contactAdmin,
          items:UIData.ChatRoom
      ),
      MenuGuide(
          title: "Timeline",
          menuColor: Color(0xff261d33),
          icon: Icons.dashboard,
          image: UIData.photos,
          items:UIData.GuideTimeline
      ),
      MenuGuide(
          title: "Photos",
          menuColor: Color(0xffe19b6b),
          icon: Icons.photo,
          image: UIData.blankImage,
          items:UIData.GuidePhotos
      ),
      MenuGuide(
          title: "Payment History",
          menuColor: Color(0xffddcec2),
          icon: Icons.payment,
          image: UIData.paymentImage,
          items:UIData.GuidePaymentHistory
      ),
    ];
  }
}
