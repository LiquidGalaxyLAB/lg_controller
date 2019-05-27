import 'package:flutter/material.dart';

class ScreenBackground
{
  static Decoration getBackgroundDecoration()
  {
    return new BoxDecoration(
      image: new DecorationImage(image: new AssetImage("image_assets/background.png"), fit: BoxFit.cover,),
    );
  }
}