import 'package:flutter/material.dart';

const MaterialColor primary = MaterialColor(_primaryPrimaryValue, <int, Color>{
  50: Color(0xFFF7FDE9),
  100: Color(0xFFEBFBC8),
  200: Color(0xFFDDF9A3),
  300: Color(0xFFCFF67E),
  400: Color(0xFFC5F463),
  500: Color(_primaryPrimaryValue),
  600: Color(0xFFB5F040),
  700: Color(0xFFACEE37),
  800: Color(0xFFA4EC2F),
  900: Color(0xFF96E820),
});
const int _primaryPrimaryValue = 0xFFBBF247;

const MaterialColor primaryAccent =
    MaterialColor(_primaryAccentValue, <int, Color>{
  100: Color(0xFFFFFFFF),
  200: Color(_primaryAccentValue),
  400: Color(0xFFE0FFB9),
  700: Color(0xFFD5FFA0),
});
const int _primaryAccentValue = 0xFFF7FFEC;
