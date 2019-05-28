import 'package:flutter/material.dart';
import 'package:lg_controller/src/utils/Images.dart';

class FlyToMenu
{
  final String title;
  final AssetImage image;
  const FlyToMenu(this.title,this.image);
  static values()
  {
    return [EARTH,SUN,MOON,SKY];
  }
  static const FlyToMenu EARTH =const FlyToMenu("Earth",Images.EARTH);
  static const FlyToMenu SUN =const FlyToMenu("Sun",Images.SUN);
  static const FlyToMenu MOON =const FlyToMenu("Moon",Images.MOON);
  static const FlyToMenu SKY =const FlyToMenu("Sky",Images.SKY);
}