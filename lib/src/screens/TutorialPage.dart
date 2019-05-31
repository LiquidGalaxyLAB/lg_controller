import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lg_controller/src/blocs/PageBloc.dart';
import 'package:lg_controller/src/states_events/PageActions.dart';
import 'package:lg_controller/src/ui/ScreenBackground.dart';

class TutorialPage extends StatefulWidget {
  TutorialPage();

  @override
  _TutorialPageState createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> with NavigatorObserver {
  @override
  void initState() {
    super.initState();
    if (!isFirstTime()) {
      BlocProvider.of<PageBloc>(context).dispatch(HOME(null));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: ScreenBackground.getBackgroundDecoration(),
        child: Center(
          child: Text("Tutorial"),
        ),
      ),
    );
  }

  bool isFirstTime() {
    return false;
  }
}
