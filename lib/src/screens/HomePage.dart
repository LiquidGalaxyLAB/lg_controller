import 'package:flutter/material.dart';
import 'package:lg_controller/src/ui/ScreenBackground.dart';
import 'package:lg_controller/src/ui/TitleBar.dart';
import 'package:lg_controller/src/menu/MainMenu.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:lg_controller/src/ui/HomeContent.dart';
import 'package:lg_controller/src/models/POIData.dart';
import 'package:lg_controller/src/models/KMLData.dart';

class HomePage extends StatefulWidget {
  KMLData data;
  HomePage(this.data);
  @override
  _HomePageState createState() => _HomePageState(data);
}

class _HomePageState extends State<HomePage> {

  KMLData data;
  _HomePageState(this.data);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () =>SystemNavigator.pop(),
    child:Scaffold(
      body: Container(
          decoration: ScreenBackground.getBackgroundDecoration(),
        child: Center(
          child:Column(
            children: <Widget>[
              SizedBox(
                height: 64,
          child:TitleBar(MainMenu.HOME),),
              Expanded(
                  child:Container(
                    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                  child:HomeContent(data)
                  ),
              ),
            ]
        ),
        ),
        ),
    ),);
  }
}