import 'package:flutter/cupertino.dart';

class AppSettings {
  static const double cardHorizontalPadding = 20;
  static const double cardVerticalPadding = 15;

  static const double cardHorizontalMargin = 35;
  static const double cardVerticalMargin = 25;

  static const double shadowSpreadRadius = 5;
  static const double shadowBlurRadius = 20;

  static double getHeight(Size? screenSize, double part) =>
      (screenSize?.height ?? 1) * part;

  static double getWidth(Size? screenSize, double part) =>
      (screenSize?.width ?? 1) * part;
}
