import 'package:flutter/material.dart';

class Palette{
  final Color _bgColor = const Color(0xFF2E3532);
  final Color _textColor = const Color(0xFFE0E2DB);

  static const int _myColorPrimaryValue = 0xFF8b2635;
  final MaterialColor _maPalette = const MaterialColor(
    _myColorPrimaryValue,
    <int, Color>{
    50: Color(0xFFf9e3e5),
    100: Color(0xFFf0b8be),
    200: Color(0xFFe48c94),
    300: Color(0xFFd7626d),
    400: Color(0xFFcb4853),
    500: Color(0xFFc1373b),
    600: Color(0xFFb2323a),
    700: Color(0xFF9e2c38),
    800: Color(_myColorPrimaryValue),
    900: Color(0xFF681e2f),
    },
  );

  Color get bgColor => _bgColor;
  Color get textColor => _textColor;
  MaterialColor get primarySwatch => _maPalette;
}