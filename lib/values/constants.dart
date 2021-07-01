import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const double cardHorizontalPadding = 20;
const double cardVerticalPadding = 15;

const double cardHorizontalMargin = 35;
const double cardVerticalMargin = 25;

const double shadowSpreadRadius = 5;
const double shadowBlurRadius = 20;

const Color textColor = Color(0xFF343434);

const Color shadowColor = Color(0xFFD4D4D4);

TextStyle contestTitleTextStyle =
    GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600);

TextStyle informationTextStyle = GoogleFonts.poppins(
    fontSize: 14, fontWeight: FontWeight.w400, color: textColor);

const Color yellowColor = Color(0xFFF6D365);
const Color peachColor = Color(0xFFFDA085);
Shader firstDivisionGradient =
    const LinearGradient(colors: <Color>[yellowColor, peachColor])
        .createShader(const Rect.fromLTRB(0, 0, 270, 70));

const Color purpleColor = Color(0xFFE0C3FC);
const Color blueColor = Color(0xFF8EC5FC);
Shader secondDivisionGradient =
    const LinearGradient(colors: <Color>[purpleColor, blueColor])
        .createShader(const Rect.fromLTRB(0, 0, 270, 70));

const Color greenColor = Color(0xFF43E97B);
const Color cyanColor = Color(0xFF38F9D7);
Shader thirdDivisionGradient =
    const LinearGradient(colors: <Color>[greenColor, cyanColor])
        .createShader(const Rect.fromLTRB(0, 0, 270, 70));

const Color pinkColor = Color(0xFFF578DC);
Shader otherDivisionContest =
    const LinearGradient(colors: <Color>[blueColor, pinkColor])
        .createShader(const Rect.fromLTRB(0, 0, 270, 70));
