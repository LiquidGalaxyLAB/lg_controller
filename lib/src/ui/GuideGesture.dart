import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lg_controller/src/models/KMLData.dart';
import 'package:lg_controller/src/osc/ModuleType.dart';
import 'package:lg_controller/src/osc/OSCActions.dart';
import 'package:lg_controller/src/utils/Images.dart';
import 'package:lg_controller/src/utils/SizeScaling.dart';

/// Gesture slide for Guide screen.
class GuideGesture extends StatefulWidget {
  GuideGesture();

  @override
  _GuideGestureState createState() => _GuideGestureState();
}

class _GuideGestureState extends State<GuideGesture> {
  /// Controller for google map.
  Completer<GoogleMapController> _controller = Completer();

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
  }

  @override
  dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Container(
      padding: new EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
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
                  "Gestures Guide",
                  style: TextStyle(
                      fontSize:
                          24 + 24 * 0.8 * (SizeScaling.getWidthScaling() - 1),
                      color: Colors.black54,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: EdgeInsets.all(
                      8.0 + 8.0 * 0.5 * (SizeScaling.getWidthScaling() - 1)),
                ),
                Text(
                  getHintText(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 8,
                  style: TextStyle(
                    fontSize:
                        16 + 16 * 0.8 * (SizeScaling.getWidthScaling() - 1),
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(
                6.0 + 6 * 0.5 * (SizeScaling.getWidthScaling() - 1)),
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
                    GoogleMap(
                      onMapCreated: (controller) =>
                          _controller.complete(controller),
                      myLocationEnabled: false,
                      onCameraMove: (cameraPosition) =>
                          setCurrent(cameraPosition),
                      mapType: MapType.satellite,
                      gestureRecognizers:
                          <Factory<OneSequenceGestureRecognizer>>[
                        new Factory<OneSequenceGestureRecognizer>(
                          () => new EagerGestureRecognizer(),
                        ),
                      ].toSet(),
                      onCameraIdle: () => changePosition(),
                      initialCameraPosition: CameraPosition(
                        target: LatLng(0.0, 0.0),
                        bearing: 0.0,
                        zoom: 0.0,
                        tilt: 0.0,
                      ),
                    ),
                    SizedBox(
                      height: 200 * SizeScaling.getWidthScaling(),
                      width: 200 * SizeScaling.getWidthScaling(),
                      child: getOverlayAnimation(),
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
  }

  /// Set current camera position.
  setCurrent(CameraPosition cameraPosition) {
    if (current != null) {
      if (overlayAnimationState == 1 &&
          (current.target.latitude != cameraPosition.target.latitude ||
              current.target.longitude != cameraPosition.target.longitude))
        stateProceed = true;
      else if (overlayAnimationState == 2 &&
          current.zoom != cameraPosition.zoom)
        stateProceed = true;
      else if (overlayAnimationState == 3 &&
          current.bearing != cameraPosition.bearing)
        stateProceed = true;
      else if (overlayAnimationState == 4 &&
          current.tilt != cameraPosition.tilt) stateProceed = true;
    }
    current = cameraPosition;
  }

  /// Complete current state.
  changePosition() {
    KMLData data = new KMLData(
        title: "Gesture",
        desc: "change",
        latitude: current.target.latitude,
        longitude: current.target.longitude,
        bearing: current.bearing,
        zoom: current.zoom,
        tilt: current.tilt);
    OSCActions().sendModule(ModuleType.GESTURE, jsonEncode(data));

    if (stateProceed) {
      stateProceed = false;
      setState(() {
        overlayAnimationState++;
        showAnimationState = true;
      });
    }
  }

  /// Get the text for instructions.
  String getHintText() {
    switch (overlayAnimationState) {
      case 0:
        return "Tap on the map to get started..";
      case 1:
        return "1 finger swipe : \n\nMove around the map by dragging with only 1 finger as indicated. \nTap to start.";
      case 2:
        return "2 finger pinch : \n\nZoom in/out by pinching the map using 2 fingers as indicated. \nTap to start.";
      case 3:
        return "2 finger swirl : \n\nRotate the map by swirling the fingers in opposite directions as indicated. \nTap to start.";
      case 4:
        return "2 finger drag : \n\nChange the 3-D perspective by dragging 2 fingers up or down as indicated. \nTap to start.";
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
          child: Image(image: Images.SWIPE_GESTURE),
        );
      case 2:
        return GestureDetector(
          onPanDown: (DragDownDetails) => setState(() {
                showAnimationState = false;
              }),
          child: Image(image: Images.ZOOM_GESTURE),
        );
      case 3:
        return GestureDetector(
          onPanDown: (DragDownDetails) => setState(() {
                showAnimationState = false;
              }),
          child: Image(image: Images.SWIRL_GESTURE),
        );
      case 4:
        return GestureDetector(
          onPanDown: (DragDownDetails) => setState(() {
                showAnimationState = false;
              }),
          child: Image(image: Images.Z_GESTURE),
        );
      default:
        return Container();
    }
  }
}
