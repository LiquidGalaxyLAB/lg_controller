import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lg_controller/src/ui/ScreenBackground.dart';

class TourPage extends StatefulWidget {
  TourPage();

  @override
  _TourPageState createState() => _TourPageState();
}

class _TourPageState extends State<TourPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => SystemNavigator.pop(),
      child: Scaffold(
        body: Container(
          decoration: ScreenBackground.getBackgroundDecoration(),
          child: Center(
            child: Text("tour"),
          ),
        ),
      ),
    );
  }
}
