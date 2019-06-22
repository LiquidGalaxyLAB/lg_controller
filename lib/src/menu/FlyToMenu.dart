import 'package:flutter/material.dart';
import 'package:lg_controller/src/utils/Images.dart';

/// Menu items for Fly To menu dialog box.
class FlyToMenu {
  final String title;
  final AssetImage image;

  const FlyToMenu(this.title, this.image);

  static values() {
    return [EARTH, MARS, MOON, SKY];
  }

  static const FlyToMenu EARTH = const FlyToMenu("Earth", Images.EARTH);
  static const FlyToMenu MARS = const FlyToMenu("Mars", Images.MARS);
  static const FlyToMenu MOON = const FlyToMenu("Moon", Images.MOON);
  static const FlyToMenu SKY = const FlyToMenu("Sky", Images.SKY);
}
