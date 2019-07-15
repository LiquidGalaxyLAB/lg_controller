import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lg_controller/src/menu/MainMenu.dart';
import 'package:lg_controller/src/ui/CardSlider.dart';
import 'package:lg_controller/src/ui/GuideGesture.dart';
import 'package:lg_controller/src/ui/ScreenBackground.dart';
import 'package:lg_controller/src/ui/TitleBar.dart';
import 'package:lg_controller/src/utils/SizeScaling.dart';

/// Guide screen root.
class GuidePage extends StatefulWidget {
  GuidePage();

  @override
  _GuidePageState createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => SystemNavigator.pop(),
      child: Scaffold(
        body: Container(
          decoration: ScreenBackground.getBackgroundDecoration(),
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 64 * SizeScaling.getHeightScaling(),
                  child: TitleBar(MainMenu.GUIDE),
                ),
                Expanded(
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                    child: Center(
                        child: CardSlider([
                      GuideGesture(),
                      Card(
                        margin: const EdgeInsets.all(8.0),
                        color: Colors.white70,
                      ),
                      Card(
                        margin: const EdgeInsets.all(8.0),
                        color: Colors.white70,
                      ),
                    ]) //Text("guide"),
                        ),
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
