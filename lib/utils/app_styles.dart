import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyles {
  static const Color textColor = Color(0xFF343434);
  static const Color shadowColor = Color(0xFFD4D4D4);

  static const Color yellowColor = Color(0xFFF6D365);
  static const Color peachColor = Color(0xFFFDA085);

  static const Color purpleColor = Color(0xFFE0C3FC);
  static const Color blueColor = Color(0xFF8EC5FC);

  static const Color greenColor = Color(0xFF43E97B);
  static const Color cyanColor = Color(0xFF38F9D7);

  static TextStyle contestTitleTextStyle =
      GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600);

  static TextStyle informationTextStyle = GoogleFonts.poppins(
      fontSize: 14, fontWeight: FontWeight.w400, color: textColor);

  static Shader firstDivisionGradient =
      const LinearGradient(colors: <Color>[yellowColor, peachColor])
          .createShader(const Rect.fromLTRB(0, 0, 270, 70));

  static Shader secondDivisionGradient =
      const LinearGradient(colors: <Color>[purpleColor, blueColor])
          .createShader(const Rect.fromLTRB(0, 0, 270, 70));

  static Shader thirdDivisionGradient =
      const LinearGradient(colors: <Color>[greenColor, cyanColor])
          .createShader(const Rect.fromLTRB(0, 0, 270, 70));

  static const Color pinkColor = Color(0xFFF578DC);
  static Shader otherDivisionContest =
      const LinearGradient(colors: <Color>[pinkColor, blueColor])
          .createShader(const Rect.fromLTRB(0, 0, 270, 70));
}
