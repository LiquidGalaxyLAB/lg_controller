import 'package:flutter/material.dart';
import 'package:lg_controller/src/ui/ScreenBackground.dart';
import 'package:lg_controller/src/ui/TitleBar.dart';
import 'package:lg_controller/src/menu/MainMenu.dart';

class POIPage extends StatefulWidget {
  POIPage();
  @override
  _POIPageState createState() => _POIPageState();
}

class _POIPageState extends State<POIPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: ScreenBackground.getBackgroundDecoration(),
        child: Center(child:new TitleBar(MainMenu.POI),),
      ),
    );
  }
}