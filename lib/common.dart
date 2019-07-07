import 'package:flutter/painting.dart';

class Colors {
  static const black = Color(0xff060518);
  static const white = Color(0xffffffff);
  static const blue = Color(0xff0029FF);
}

class Fonts {
  static const String AirbnbCereal = 'AirbnbCereal';
}

class TextStyles {
  static const airbnbCerealMedium = TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontFamily: Fonts.AirbnbCereal);
  static const airbnbCerealBook = TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontFamily: Fonts.AirbnbCereal);
}