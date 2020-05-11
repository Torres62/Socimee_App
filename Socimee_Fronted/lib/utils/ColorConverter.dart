import 'package:flutter/material.dart';

class ColorConverter{
  Color _colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }

  Color backgroundFirstColor() => _colorFromHex('#489fec');
  Color backgroundSecondColor() => _colorFromHex('a55af5');
  Color textBlueColor() => _colorFromHex('1b0b87');
  Color textGreyColor() => _colorFromHex('AFB6C0');
}