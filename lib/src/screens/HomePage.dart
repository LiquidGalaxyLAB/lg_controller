import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lg_controller/src/menu/MainMenu.dart';
import 'package:lg_controller/src/models/KMLData.dart';
import 'package:lg_controller/src/models/OverlayData.dart';
import 'package:lg_controller/src/models/POIData.dart';
import 'package:lg_controller/src/models/TourData.dart';
import 'package:lg_controller/src/osc/ModuleType.dart';
import 'package:lg_controller/src/osc/OSCActions.dart';
import 'package:lg_controller/src/ui/HomeContent.dart';
import 'package:lg_controller/src/ui/ScreenBackground.dart';
import 'package:lg_controller/src/ui/TitleBar.dart';
import 'package:lg_controller/src/utils/SizeScaling.dart';

/// Home screen root.
class HomePage extends StatefulWidget {
  final KMLData data;

  HomePage(this.data);

  @override
  _HomePageState createState() => _HomePageState(data);
}

class _HomePageState extends State<HomePage> {
  KMLData data;

  _HomePageState(this.data);

  @override
  void initState() {
    if (data != null) {
      if (data is POIData)
        OSCActions().sendModule(ModuleType.POI, jsonEncode(data));
      else if (data is TourData)
        OSCActions().sendModule(ModuleType.TOUR, jsonEncode(data));
      else if (data is OverlayData)
        OSCActions().sendModule(ModuleType.OVERLAY, jsonEncode(data));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => SystemNavigator.pop(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: ScreenBackground.getBackgroundDecoration(),
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 64 * SizeScaling.getHeightScaling(),
                  child: TitleBar(MainMenu.HOME),
                ),
                Expanded(
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                    child: HomeContent(data),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
