import 'dart:ui';

import 'package:flutter/material.dart';

Color getColorFromHex(String hexColor) {
  if (hexColor != null) {
    hexColor = hexColor.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    } else {
      return Colors.grey;
    }
  } else {
    return Colors.grey;
  }
}
