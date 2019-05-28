import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lg_controller/src/screens/HomePage.dart';
import 'package:lg_controller/src/screens/GuidePage.dart';
import 'package:lg_controller/src/screens/OverlayPage.dart';
import 'package:lg_controller/src/screens/POIPage.dart';
import 'package:lg_controller/src/screens/ProfilePage.dart';
import 'package:lg_controller/src/screens/SettingsPage.dart';
import 'package:lg_controller/src/screens/TourPage.dart';

void main() => runApp(MyApp());

var routes = <String, WidgetBuilder>{
  "/HomePage": (BuildContext context) => new HomePage(),
  "/GuidePage": (BuildContext context) => new GuidePage(),
  "/OverlayPage": (BuildContext context) => new OverlayPage(),
  "/POIPage": (BuildContext context) => new POIPage(),
  "/ProfilePage": (BuildContext context) => new ProfilePage(),
  "/SettingsPage": (BuildContext context) => new SettingsPage(),
  "/TourPage": (BuildContext context) => new TourPage()
};


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.teal,
          cardColor: Colors.white,
        iconTheme: new IconThemeData(
            color: Colors.white,
            opacity: 1.0,
        ),
          fontFamily: 'RobotoMono',
          textTheme: TextTheme(
            headline:    TextStyle(fontSize: 34, color:Colors.white, fontWeight: FontWeight.bold),
            title:       TextStyle(fontSize: 20, color:Colors.black, fontWeight: FontWeight.bold),
            body1:        TextStyle(fontSize: 12, color:Colors.white),
            body2:        TextStyle(fontSize: 16, color:Colors.white, fontWeight: FontWeight.bold),

    ),
      ),
      home: HomePage(),
    );
  }
}
