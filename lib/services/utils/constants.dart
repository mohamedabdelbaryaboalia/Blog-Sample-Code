import 'package:flutter/material.dart';

mixin Constants {
  // * URL
  static const String mainUrl =
      "https://60585b2ec3f49200173adcec.mockapi.io/api/v1/";
  // * APP MODE
  static const debugMode = true;

  // * COLORS
  static Color themePrimary = HexColor("#ff4081");
  static Color themeAccent = HexColor("#f50057");

  // * FUNCTION TO CHECK IF IS NUMERIC
  static bool isNumeric(String? s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }
}

// *  CLASS TO GET COLOR FROM HEX CODE
class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    String updatedHexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (updatedHexColor.length == 6) {
      updatedHexColor = "FF$updatedHexColor";
    }
    return int.parse(updatedHexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
