import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lg_controller/src/ui/ScreenBackground.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lg_controller/src/states_events/PageActions.dart';
import 'package:lg_controller/src/blocs/PageBloc.dart';
import 'package:lg_controller/src/screens/HomePage.dart';
import 'package:lg_controller/src/screens/GuidePage.dart';
import 'package:lg_controller/src/screens/OverlayPage.dart';
import 'package:lg_controller/src/screens/POIPage.dart';
import 'package:lg_controller/src/screens/ProfilePage.dart';
import 'package:lg_controller/src/screens/SettingsPage.dart';
import 'package:lg_controller/src/screens/TourPage.dart';
import 'package:lg_controller/src/screens/TutorialPage.dart';
import 'package:page_transition/page_transition.dart';

class TutorialPage extends StatefulWidget {
  TutorialPage();
  @override
  _TutorialPageState createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> with NavigatorObserver{

  @override
  void initState() {
    super.initState();
    if(!isFirstTime()){
      BlocProvider.of<PageBloc>(context).dispatch(HOME(null));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: ScreenBackground.getBackgroundDecoration(),
        child: Center(
            child:Text("Tutorial"),
        ),
      ),
    );
  }
  bool isFirstTime()
  {
    return false;
  }
}