import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

void main() => runApp(MyApp());

var routes = <String, WidgetBuilder>{
  "/HomePage": (BuildContext context) => new HomePage(),
  "/GuidePage": (BuildContext context) => new GuidePage(),
  "/OverlayPage": (BuildContext context) => new OverlayPage(),
  "/POIPage": (BuildContext context) => new POIPage(),
  "/ProfilePage": (BuildContext context) => new ProfilePage(),
  "/SettingsPage": (BuildContext context) => new SettingsPage(),
  "/TourPage": (BuildContext context) => new TourPage(),
  "/TutorialPage": (BuildContext context) => new TutorialPage()
};

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  PageBloc pageBloc = PageBloc();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    return BlocProvider<PageBloc>(
      bloc: pageBloc,
      child: MaterialApp(
        title: 'LG Controller',
        routes: routes,
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
            headline: TextStyle(
                fontSize: 34, color: Colors.white, fontWeight: FontWeight.bold),
            title: TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
            body1: TextStyle(fontSize: 12, color: Colors.white),
            body2: TextStyle(
                fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),

          ),
        ),
        home: BlocListener(
          bloc: pageBloc,
          child: TutorialPage(),
          listener: (BuildContext context, PageState state) {
            if (state is HomeState) {
              Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, duration: Duration(milliseconds: 500), child: HomePage()));
            }
            else if (state is POIState) {
              Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, duration: Duration(milliseconds: 500), child: POIPage()));
            }
            else if (state is GuideState) {
              Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, duration: Duration(milliseconds: 500), child: GuidePage()));
            }
            else if (state is OverState) {
              Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, duration: Duration(milliseconds: 500), child: OverlayPage()));
            }
            else if (state is TourState) {
              Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, duration: Duration(milliseconds: 500), child: TourPage()));
            }
            else if (state is ProfileState) {
              Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, duration: Duration(milliseconds: 500), child: ProfilePage()));
            }
            else if (state is SettingsState) {
              Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, duration: Duration(milliseconds: 500), child: SettingsPage()));
            }
            else if(state is TutorialState)
              {
                Navigator.popAndPushNamed(context, '/TutorialPage');
              }
          },
        ),
      ),
    );
  }
  @override
  void dispose() {
    super.dispose();
    pageBloc.dispose();
  }
}
