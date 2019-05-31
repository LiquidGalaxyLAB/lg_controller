import 'package:flutter/material.dart';
import 'package:lg_controller/src/utils/Images.dart';

class ScreenBackground {
  static Decoration getBackgroundDecoration() {
    return new BoxDecoration(
      image: new DecorationImage(
        image: Images.BACKGROUND,
        fit: BoxFit.cover,
      ),
    );
  }
}
