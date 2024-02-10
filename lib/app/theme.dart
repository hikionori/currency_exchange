import 'dart:ui';

import 'package:google_fonts/google_fonts.dart';

abstract final class BaseColors {
  static const Color background = Color(0xfffffffe);
  static const Color button = const Color(0xffffd803);

  static const Color headerText = const Color(0xff272343);
  static const Color inputText = const Color(0xff2D334A);
  static Color placeholderText = Color(0xff2d334a).withOpacity(0.48);

  static const Color layoutButton = const Color(0xffBAE8E8);
  static const Color layoutButtonText = const Color(0xff272343);
  static Color layoutButtonActiveText =
      const Color(0xff2D334A).withOpacity(0.7);
  static const Color layoutButtonActive = const Color(0xffE3F6F5);
  static const Color layoutButtonActiveBorder = const Color(0xffBAE8E8);

  static const Color textFieldBorder = const Color(0xff272343);
}

abstract final class BaseFont {
}
