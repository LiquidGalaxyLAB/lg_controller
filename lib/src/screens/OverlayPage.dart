import 'package:flutter/material.dart';
import 'package:lg_controller/src/ui/ScreenBackground.dart';

class OverlayPage extends StatefulWidget {
  OverlayPage();
  @override
  _OverlayPageState createState() => _OverlayPageState();
}

class _OverlayPageState extends State<OverlayPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: ScreenBackground.getBackgroundDecoration(),
        child: Center(child:Text("Overlay"),),
      ),
    );
  }
}