import 'package:flutter/material.dart';

class CustomColors{
  static const MaterialColor pinkpalette = MaterialColor(_pinkpalettePrimaryValue, <int, Color>{
    50: Color(0xFFF8E7F0),
    100: Color(0xFFEDC4D9),
    200: Color(0xFFE19DC0),
    300: Color(0xFFD576A6),
    400: Color(0xFFCC5893),
    500: Color(_pinkpalettePrimaryValue),
    600: Color(0xFFBD3578),
    700: Color(0xFFB52D6D),
    800: Color(0xFFAE2663),
    900: Color(0xFFA11950),
  });
  static const int _pinkpalettePrimaryValue = 0xFFC33B80;

  static const MaterialColor pinkpaletteAccent = MaterialColor(_pinkpaletteAccentValue, <int, Color>{
    100: Color(0xFFFFD6E5),
    200: Color(_pinkpaletteAccentValue),
    400: Color(0xFFFF70A6),
    700: Color(0xFFFF5796),
  });
  static const int _pinkpaletteAccentValue = 0xFFFFA3C6;
}