import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lg_controller/src/blocs/FreezeBloc.dart';
import 'package:lg_controller/src/blocs/PointBloc.dart';
import 'package:lg_controller/src/menu/MainMenu.dart';
import 'package:lg_controller/src/ui/OverlayMapView.dart';
import 'package:lg_controller/src/ui/OverlayMenuBar.dart';
import 'package:lg_controller/src/ui/ScreenBackground.dart';
import 'package:lg_controller/src/ui/TitleBar.dart';
import 'package:lg_controller/src/utils/SizeScaling.dart';

/// Overlay screen root.
class OverlayPage extends StatefulWidget {
  OverlayPage();

  @override
  _OverlayPageState createState() => _OverlayPageState();
}

class _OverlayPageState extends State<OverlayPage> {
  PointBloc pBloc;
  FreezeBloc fBloc;

  @override
  void initState() {
    pBloc = PointBloc();
    fBloc = FreezeBloc(pBloc);
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
                  child: TitleBar(MainMenu.OVERLAY),
                ),
                Expanded(
                  child: BlocProviderTree(
                    blocProviders: [
                      BlocProvider<FreezeBloc>(bloc: fBloc),
                      BlocProvider<PointBloc>(bloc: pBloc),
                    ],
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                      child: Center(
                        child: SizedBox(
                          width: 540 * SizeScaling.getWidthScaling(),
                          height: 280 * SizeScaling.getHeightScaling(),
                          child: Card(
                              elevation: 4,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Stack(
                                  children: <Widget>[
                                    OverlayMapView(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        OverlayMenuBar(),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              color: Colors.white70),
                        ),
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

  @override
  void dispose() {
    pBloc.dispose();
    fBloc.dispose();
    super.dispose();
  }
}
