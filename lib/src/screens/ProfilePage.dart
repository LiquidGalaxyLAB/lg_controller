import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lg_controller/src/menu/MainMenu.dart';
import 'package:lg_controller/src/ui/ProfileContent.dart';
import 'package:lg_controller/src/ui/ScreenBackground.dart';
import 'package:lg_controller/src/ui/TitleBar.dart';
import 'package:lg_controller/src/utils/SizeScaling.dart';

/// Profile screen root.
class ProfilePage extends StatefulWidget {
  ProfilePage();

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
                  child: TitleBar(MainMenu.NONE),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(
                        8 + (8 * 0.7 * SizeScaling.getWidthScaling() - 1)),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 400 +
                                (400 * (SizeScaling.getWidthScaling() - 1)),
                            height: 268 +
                                (272 * (SizeScaling.getHeightScaling() - 1)),
                            child: Card(
                                elevation: 4,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Container(
                                    margin: EdgeInsets.all(4),
                                    child: ProfileContent(),
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                color: Colors.white70),
                          ),
                        ],
                      ),
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
