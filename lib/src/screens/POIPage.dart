import 'package:flutter/material.dart';
import 'package:lg_controller/src/ui/ScreenBackground.dart';
import 'package:lg_controller/src/ui/TitleBar.dart';
import 'package:lg_controller/src/menu/MainMenu.dart';
import 'package:flutter/services.dart';
import 'package:lg_controller/src/ui/POIContent.dart';
import 'package:lg_controller/src/models/POIData.dart';
import 'package:lg_controller/src/ui/NavBar.dart';
import 'package:lg_controller/src/ui/SearchBar.dart';

class POIPage extends StatefulWidget {
  POIPage();
  @override
  _POIPageState createState() => _POIPageState();
}

class _POIPageState extends State<POIPage> {

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
                  child:TitleBar(MainMenu.POI),),
                Expanded(
                  child:Container(
                      padding: EdgeInsets.fromLTRB(0,8,8,0),
                      child:Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              width: 160,
                              child: Container(
                                color: Colors.blueGrey[800],
                              child:NavBar(),),),
                            Expanded(
                                child:Column(
                                  children: <Widget>[
                                    SearchBar(),
                                    Expanded(
                                    child:POIContent(),),
                                  ]),
                              ),
                            ]
                      ),
                  ),),

              ]
          ),
        ),
      ),
    ),);
  }
}