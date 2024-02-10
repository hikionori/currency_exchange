import 'dart:ui';

abstract final class BaseColors {
  static const Color background = Color(0xfffffffe);
  static const Color button = Color(0xffffd803);

  static const Color headerText = Color(0xff272343);
  static const Color inputText = Color(0xff2D334A);
  static Color placeholderText = const Color(0xff2d334a).withOpacity(0.48);

  static const Color layoutButton = Color(0xffBAE8E8);
  static const Color layoutButtonText = Color(0xff272343);
  static Color layoutButtonActiveText =
      const Color(0xff2D334A).withOpacity(0.7);
  static const Color layoutButtonActive = Color(0xffE3F6F5);
  static const Color layoutButtonActiveBorder = Color(0xffBAE8E8);

  static const Color textFieldBorder = Color(0xff272343);
}
