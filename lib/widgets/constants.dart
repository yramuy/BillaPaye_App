import 'package:flutter/material.dart';

class Constants {

  static Color lightBlue = const Color(0xFF336799);
  static Color darkBlue = const Color(0xFF1F4061);
  static Color lightShadeColor = const Color(0xFFe1e2e0);
  static String landingBg = 'assets/images/landing_bg.jpg';
  static String logoImage = 'assets/images/logo.png';
  static String swipeIcon = 'assets/icons/swipe_icon.png';
  static String restaurantIcon = 'assets/icons/restaurant.png';
  static String clothingIcon = 'assets/icons/clothing.png';
  static String salonIcon = 'assets/icons/salon.png';
  static String spaIcon = 'assets/icons/spa.png';
  static String beautyParlourIcon = 'assets/icons/beauty_parlour.png';
  static String hotelIcon = 'assets/icons/hotel.png';
  static String cafeIcon = 'assets/icons/cafe.png';
  static String ticketBookingIcon = 'assets/icons/ticket_booking.png';

  /*static void easyLoader() {
    EasyLoading.instance
    // ..displayDuration = const Duration(seconds: 5)
      ..textStyle = TextStyle(fontWeight: FontWeight.bold, color: buttonRed)
      ..loadingStyle =
          EasyLoadingStyle.custom //This was missing in earlier code
      ..backgroundColor = whiteColor
      ..userInteractions = false
      ..indicatorColor = buttonRed
      ..indicatorWidget = SizedBox(
        width: 80,
        height: 80,
        child: SpinKitCircle(
          color: buttonRed,
          size: 60.0,
        ),
      )
      ..infoWidget = SizedBox(
        width: 80,
        height: 80,
        child: Center(
            child: Icon(
              Icons.error,
              color: buttonRed,
              size: 50,
            )),
      )
      ..successWidget = SizedBox(
        width: 80,
        height: 80,
        child: Center(
            child: Icon(
              Icons.check,
              color: buttonRed,
              size: 50,
            )),
      )
      ..maskType = EasyLoadingMaskType.black
      ..dismissOnTap = false;
  }*/
}
