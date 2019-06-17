import 'package:flutter/material.dart';
import 'package:lg_controller/src/ui/AuxillaryMenuBar.dart';

/// Menu items for [AuxillaryMenuBar].
class AuxillaryMenu {
  final String title;
  final Icon icon;

  const AuxillaryMenu(this.title, this.icon);

  static values() {
    return [PROFILE, SETTINGS, ADDITIONAL];
  }

  static const AuxillaryMenu PROFILE = const AuxillaryMenu("Profile",
      Icon(IconData(0xe7ff, fontFamily: 'MaterialIcons'), color: Colors.white));
  static const AuxillaryMenu SETTINGS = const AuxillaryMenu("Settings",
      Icon(IconData(59576, fontFamily: 'MaterialIcons'), color: Colors.white));
  static const AuxillaryMenu ADDITIONAL = const AuxillaryMenu("Additional menu",
      Icon(IconData(58836, fontFamily: 'MaterialIcons'), color: Colors.white));
}
