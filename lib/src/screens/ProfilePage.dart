import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lg_controller/src/ui/ScreenBackground.dart';

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
        body: Container(
          decoration: ScreenBackground.getBackgroundDecoration(),
          child: Center(
            child: Text("Profile"),
          ),
        ),
      ),
    );
  }
}
