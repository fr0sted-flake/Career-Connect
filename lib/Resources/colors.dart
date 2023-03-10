import 'package:flutter/material.dart';

hexStringToColor(String colours) {
  colours = colours.toUpperCase().replaceAll("#", "");
  if (colours.length == 6) {
    colours = "FF$colours";
  }
  return Color(int.parse(colours, radix: 16));
}
