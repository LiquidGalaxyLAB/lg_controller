import 'package:flutter/material.dart';
import 'package:lg_controller/src/ui/OverlayMenuBar.dart';

/// Menu items for POI [OverlayMenuBar].
class OverlayMenu {
  final String title;
  final Icon icon;

  const OverlayMenu(this.title, this.icon);

  static values() {
    return [LINE, POLYGON, CIRCLE, ROUND_TEMP, IMAGE, PAN, SAVE];
  }

  static const OverlayMenu LINE = const OverlayMenu(
      "Line", Icon(IconData(57691, fontFamily: 'MaterialIcons')));
  static const OverlayMenu POLYGON = const OverlayMenu(
      "Polygon", Icon(IconData(58310, fontFamily: 'MaterialIcons')));
  static const OverlayMenu CIRCLE = const OverlayMenu(
      "Circle", Icon(IconData(59446, fontFamily: 'MaterialIcons')));
  static const OverlayMenu ROUND_TEMP = const OverlayMenu(
      "Round Template", Icon(IconData(58719, fontFamily: 'MaterialIcons')));
  static const OverlayMenu IMAGE = const OverlayMenu(
      "Image", Icon(IconData(58384, fontFamily: 'MaterialIcons')));
  static const OverlayMenu PAN = const OverlayMenu(
      "Pan", Icon(IconData(59685, fontFamily: 'MaterialIcons')));
  static const OverlayMenu SAVE = const OverlayMenu(
      "Save", Icon(IconData(57697, fontFamily: 'MaterialIcons')));
}
