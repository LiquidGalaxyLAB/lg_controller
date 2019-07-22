import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lg_controller/src/blocs/FreezeBloc.dart';
import 'package:lg_controller/src/blocs/PageBloc.dart';
import 'package:lg_controller/src/blocs/PointBloc.dart';
import 'package:lg_controller/src/menu/MainMenu.dart';
import 'package:lg_controller/src/menu/OverlayMenu.dart';
import 'package:lg_controller/src/states_events/PageActions.dart';
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        OverlayMenuBar(),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.all(16),
                                          child: Card(
                                              elevation: 4,
                                              child: IconButton(
                                                iconSize: 24 +
                                                    24 *
                                                        0.5 *
                                                        (SizeScaling
                                                                .getWidthScaling() -
                                                            1),
                                                key: Key('New_Overlay'),
                                                icon: OverlayMenu.NEW.icon,
                                                color: Colors.black54,
                                                tooltip: OverlayMenu.NEW.title,
                                                onPressed: () =>
                                                    BlocProvider.of<PageBloc>(
                                                            context)
                                                        .dispatch(OVERLAY()),
                                              ),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              color: Colors.white70),
                                        ),
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
