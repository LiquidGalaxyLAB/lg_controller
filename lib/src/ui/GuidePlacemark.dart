import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lg_controller/src/blocs/FreezeBloc.dart';
import 'package:lg_controller/src/blocs/PointBloc.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lg_controller/src/menu/OverlayMenu.dart';
import 'package:lg_controller/src/states_events/OverlayActions.dart';
import 'package:lg_controller/src/states_events/PointActions.dart';
import 'package:lg_controller/src/models/PlacemarkData.dart';
import 'package:lg_controller/src/ui/OverlayMapView.dart';
import 'package:lg_controller/src/utils/Images.dart';
import 'package:lg_controller/src/utils/SizeScaling.dart';

/// Placemark slide for Guide screen.
class GuidePlacemark extends StatefulWidget {
  GuidePlacemark();

  @override
  _GuidePlacemarkState createState() => _GuidePlacemarkState();
}

class _GuidePlacemarkState extends State<GuidePlacemark> {
  PointBloc pBloc;
  FreezeBloc fBloc;

  /// Current position of camera of the map.
  CameraPosition current;

  /// To denote current state completion.
  bool stateProceed;

  /// Current state.
  int overlayAnimationState;

  /// To denote whether to show animation of current state.
  bool showAnimationState;

  @override
  initState() {
    super.initState();
    overlayAnimationState = 0;
    stateProceed = false;
    showAnimationState = true;
    pBloc = PointBloc();
    fBloc = FreezeBloc(pBloc);
    fBloc.dispatch(FREEZE(OverlayMenu.SAVE));
  }

  @override
  dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    return BlocProviderTree(
      blocProviders: [
        BlocProvider<FreezeBloc>(bloc: fBloc),
        BlocProvider<PointBloc>(bloc: pBloc),
      ],
      child: BlocBuilder<PointEvent, PointState>(
          bloc: BlocProvider.of<PointBloc>(context),
          builder: (BuildContext context, PointState state) {
            return BlocBuilder<OverlayEvent, OverlaysState>(
                bloc: BlocProvider.of<FreezeBloc>(context),
                builder: (BuildContext context, OverlaysState state) {
                  if ( //state is CompletedState &&
                      pBloc.data != null &&
                          pBloc.data.length > 0 &&
                          pBloc.data[0] is PlacemarkData) {
                    if (overlayAnimationState == 3) {
                      overlayAnimationState++;
                      showAnimationState = true;
                    }
                  }
                  if (state is FrozenState &&
                      state.menu ==
                          OverlayMenu.ROUND_TEMP) if (overlayAnimationState ==
                      2) {
                    overlayAnimationState++;
                    showAnimationState = true;
                  }
                  if (state is UnfrozenState) if (overlayAnimationState == 1) {
                    overlayAnimationState++;
                    showAnimationState = true;
                  }
                  return Container(
                    padding: new EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Placemark Guide",
                                style: TextStyle(
                                    fontSize: 24 +
                                        24 *
                                            0.8 *
                                            (SizeScaling.getWidthScaling() - 1),
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0 +
                                    8.0 *
                                        0.5 *
                                        (SizeScaling.getWidthScaling() - 1)),
                              ),
                              Text(
                                getHintText(),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 8,
                                style: TextStyle(
                                  fontSize: 16 +
                                      16 *
                                          0.8 *
                                          (SizeScaling.getWidthScaling() - 1),
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(6.0 +
                              6 * 0.5 * (SizeScaling.getWidthScaling() - 1)),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: SizedBox(
                            height: 200 * SizeScaling.getWidthScaling(),
                            width: 200 * SizeScaling.getWidthScaling(),
                            child: Card(
                              margin: const EdgeInsets.all(8.0),
                              child: Stack(
                                children: <Widget>[
                                  Stack(
                                    children: <Widget>[
                                      OverlayMapView(),
                                      PlacemarkMenu(),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
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
                                                  tooltip:
                                                      OverlayMenu.NEW.title,
                                                  onPressed: () {
                                                    if (overlayAnimationState ==
                                                        4) {
                                                      setState(() {
                                                        overlayAnimationState++;
                                                        showAnimationState =
                                                            true;
                                                      });
                                                    }
                                                    pBloc.data.clear();
                                                    BlocProvider.of<PointBloc>(
                                                            context)
                                                        .dispatch(
                                                            MODIFY_EVENT());
                                                  },
                                                ),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                color: Colors.white70),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height:
                                            200 * SizeScaling.getWidthScaling(),
                                        width:
                                            200 * SizeScaling.getWidthScaling(),
                                        child: getOverlayAnimation(),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              color: Colors.white70,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                });
          }),
    );
  }

  /// Get the text for instructions.
  String getHintText() {
    switch (overlayAnimationState) {
      case 0:
        return "Tap on the map to get started..";
      case 1:
        return "Pan tool : \n\nPerform all gestures on the map with this tool enabled. \n Select this tool and try a gesture to proceed.";
      case 2:
        return "Placemark tool : \n\nSelect this tool to create a placemark. \nTap to start.";
      case 3:
        return "Add placemark : \n\nTap on a point on the map at which you want to add the placemark. \nTap to start.";
      case 4:
        return "Clear overlays : \n\nRefresh the draw pad to clear all contents and start a fresh KML. \nTap to start.";
      default:
        return "Done..";
    }
  }

  /// Get the overlay animation.
  Widget getOverlayAnimation() {
    if (showAnimationState == false) return Container();
    switch (overlayAnimationState) {
      case 0:
        return GestureDetector(
          onTap: () => setState(() {
                overlayAnimationState++;
                showAnimationState = true;
              }),
          child: Card(
            color: Colors.white54,
          ),
        );
      case 1:
        return GestureDetector(
          onPanDown: (DragDownDetails) => setState(() {
                showAnimationState = false;
              }),
          child: Image(image: Images.TAP_GESTURE),
        );
      case 2:
        return GestureDetector(
          onPanDown: (DragDownDetails) => setState(() {
                showAnimationState = false;
              }),
          child: Image(image: Images.TAP_GESTURE),
        );
      case 3:
        return GestureDetector(
          onPanDown: (DragDownDetails) => setState(() {
                showAnimationState = false;
              }),
          child: Image(image: Images.TAP_GESTURE),
        );
      case 4:
        return GestureDetector(
          onPanDown: (DragDownDetails) => setState(() {
                showAnimationState = false;
              }),
          child: Image(image: Images.TAP_GESTURE),
        );
      default:
        return Container();
    }
  }
}

/// Placemark menubar for the slide.
class PlacemarkMenu extends StatelessWidget {
  /// Current selected menu.
  OverlayMenu selected;

  PlacemarkMenu();

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Card(
          elevation: 4,
          child: BlocBuilder<PointEvent, PointState>(
              bloc: BlocProvider.of<PointBloc>(context),
              builder: (BuildContext context, PointState state) {
                return BlocBuilder<OverlayEvent, OverlaysState>(
                    bloc: BlocProvider.of<FreezeBloc>(context),
                    builder: (BuildContext context, OverlaysState state) {
                      if (state is FrozenState)
                        selected = state.menu;
                      else if (state is UnfrozenState)
                        selected = OverlayMenu.PAN;
                      return Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: getIcons(context),
                        ),
                      );
                    });
              }),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: Colors.white70),
    );
  }

  /// Get icons for the overlay menu options.
  List<Widget> getIcons(context) {
    List<Widget> list = new List<Widget>();
    list.add(
      IconButton(
        iconSize: 24 + 24 * 0.5 * (SizeScaling.getWidthScaling() - 1),
        key: Key('OverlayMenu_items_' + OverlayMenu.ROUND_TEMP.title),
        icon: OverlayMenu.ROUND_TEMP.icon,
        color:
            (selected == OverlayMenu.ROUND_TEMP) ? Colors.teal : Colors.black54,
        onPressed: () {
          BlocProvider.of<FreezeBloc>(context)
              .dispatch(FREEZE(OverlayMenu.ROUND_TEMP));
        },
        tooltip: OverlayMenu.ROUND_TEMP.title,
      ),
    );

    list.add(
      IconButton(
        iconSize: 24 + 24 * 0.5 * (SizeScaling.getWidthScaling() - 1),
        key: Key('OverlayMenu_items_' + OverlayMenu.PAN.title),
        icon: OverlayMenu.PAN.icon,
        color: (selected == OverlayMenu.PAN) ? Colors.teal : Colors.black54,
        onPressed: () =>
            BlocProvider.of<FreezeBloc>(context).dispatch(UNFREEZE(null)),
        tooltip: OverlayMenu.PAN.title,
      ),
    );
    return list;
  }
}
