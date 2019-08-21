import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
// import 'package:tt/Screens/Guide/GuideFirst.dart';

class UIData {

  //routes
  static const String GuideProfile= "GuidePofile";
  static const String TouristProfile= "TouristProfile";
  static const String Notifications = "Notifications";
  static const String Timeline = "Timeline";
  static const String JoinTrip = "JoinTrip";
  static const String ChatRoom = "ChatRoom";
  static const String Payment = "Payments";
  static const String TouristPhotos = "TouristPhotos";
  static const String GuidePhotos = "GuidePhotos";
  static const String ConfirmRequest = "ConfirmRequest";
  static const String AdminContact = "AdminContact";
  static const String GuideTimeline = "GuideTimeline";
  static const String GuidePaymentHistory = "GuidePaymentHistory";

  

  //strings
  static const String appName = "Tourist 2 Townie";

  //fonts
  static const String quickFont = "Quicksand";
  static const String ralewayFont = "Raleway";
  static const String quickBoldFont = "Quicksand_Bold.otf";
  static const String quickNormalFont = "Quicksand_Book.otf";
  static const String quickLightFont = "Quicksand_Light.otf";

  //images
  static const String imageDir = "assets/images";
  static const String pkImage = "$imageDir/pk.jpg";
  static const String profileImage = "$imageDir/profile.jpg";
  static const String blankImage = "$imageDir/blank.jpg";
  static const String photos = "$imageDir/photos.jpg";
  static const String contactAdmin = "$imageDir/contact.jpg";
  static const String paymentImage = "$imageDir/payment.jpg";
  static const String settingsImage = "$imageDir/settings.jpg";
  static const String shoppingImage = "$imageDir/shopping.jpeg";
  static const String timelineImage = "$imageDir/timeline.jpg";
  static const String verifyImage = "$imageDir/verification.jpg";
  static const String profileAvatar = "$imageDir/profilrAvatar.jpg";

  

  

//colors
  static List<Color> kitGradients = [
    // new Color.fromRGBO(103, 218, 255, 1.0),
    // new Color.fromRGBO(3, 169, 244, 1.0),
    // new Color.fromRGBO(0, 122, 193, 1.0),
    Colors.blueGrey.shade800,
    Colors.black87,
  ];
  static List<Color> kitGradients2 = [
    Colors.cyan.shade600,
    Colors.blue.shade900
  ];

  //randomcolor
  static final Random _random = new Random();

  /// Returns a random color.
  static Color next() {
    return new Color(0xFF000000 + _random.nextInt(0x00FFFFFF));
  }
}

