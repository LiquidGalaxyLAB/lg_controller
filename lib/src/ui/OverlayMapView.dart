import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lg_controller/src/blocs/FreezeBloc.dart';
import 'package:lg_controller/src/blocs/PointBloc.dart';
import 'package:lg_controller/src/menu/OverlayMenu.dart';
import 'package:lg_controller/src/models/KMLData.dart';
import 'package:lg_controller/src/models/PlacemarkData.dart';
import 'package:lg_controller/src/osc/ModuleType.dart';
import 'package:lg_controller/src/osc/OSCActions.dart';
import 'package:lg_controller/src/states_events/OverlayActions.dart';
import 'package:lg_controller/src/states_events/PointActions.dart';
import 'package:lg_controller/src/ui/PropertiesDialog.dart';

/// Overlay (Google map view).
class OverlayMapView extends StatelessWidget {
  /// Controller for google map.
  Completer<GoogleMapController> _controller = Completer();

  /// Current position of camera of the map.
  CameraPosition current;

  /// Markers of the google map.
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  /// Freeze state of the map.
  bool unfreeze = true;

  /// Currently selected overlay menu.
  OverlayMenu menu;

  OverlayMapView();

  Widget build(BuildContext context) {
    _controller = Completer();
    return BlocBuilder<OverlayEvent, OverlaysState>(
        bloc: BlocProvider.of<FreezeBloc>(context),
        builder: (BuildContext context, OverlaysState state) {
          if (state is FrozenState) {
            unfreeze = false;
            menu = state.menu;
          } else if (state is UnfrozenState) {
            unfreeze = true;
            menu = OverlayMenu.PAN;
          }
          return BlocBuilder<PointEvent, PointState>(
              bloc: BlocProvider.of<PointBloc>(context),
              builder: (BuildContext context, PointState state) {
                if (state is CompletedState) {
                  BlocProvider.of<FreezeBloc>(context).dispatch(UNFREEZE(null));
                }
                if (state is UninitializedState) {
                  markers = <MarkerId, Marker>{};
                  for (var i in state.data) {
                    markers[MarkerId((i as PlacemarkData).id)] = new Marker(
                      onTap: () => showDialog(
                          context: context,
                          builder: (BuildContext context2) {
                            return PropertiesDialog(
                                markers[MarkerId((i as PlacemarkData).id)],
                                OverlayMenu.ROUND_TEMP, (data) {
                              print((i as PlacemarkData).title);
                              state.data.remove(i);
                              state.data.add(data);
                              BlocProvider.of<PointBloc>(context)
                                  .dispatch(MODIFY_EVENT());
                            }, () {
                              state.data.remove(i);
                              BlocProvider.of<PointBloc>(context)
                                  .dispatch(MODIFY_EVENT());
                            });
                          }),
                      consumeTapEvents: true,
                      markerId: MarkerId((i as PlacemarkData).id),
                      position: (i as PlacemarkData).point,
                      infoWindow: InfoWindow(
                        title: (i as PlacemarkData).title,
                        snippet: (i as PlacemarkData).desc,
                      ),
                      zIndex: (i as PlacemarkData).zInd,
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                          (i as PlacemarkData).iconColor),
                    );
                  }
                }
                return GoogleMap(
                  rotateGesturesEnabled: unfreeze,
                  scrollGesturesEnabled: unfreeze,
                  tiltGesturesEnabled: unfreeze,
                  zoomGesturesEnabled: unfreeze,
                  onTap: (point) => sendPoint(context, point),
                  onMapCreated: (controller) =>
                      _controller.complete(controller),
                  onCameraMove: (cameraPosition) =>
                      this.current = cameraPosition,
                  onCameraIdle: () => changePosition(context),
                  mapType: MapType.satellite,
                  markers: Set<Marker>.of(markers.values),
                  initialCameraPosition: CameraPosition(
                    target: LatLng(0.0, 0.0),
                    bearing: 0.0,
                    zoom: 0.0,
                    tilt: 0.0,
                  ),
                );
              });
        });
  }

  /// Initiate OSC and unfreeze action on change in camera position.
  changePosition(context) {
    KMLData data = new KMLData(
        title: "Gesture",
        desc: "change",
        latitude: current.target.latitude,
        longitude: current.target.longitude,
        bearing: current.bearing,
        zoom: current.zoom,
        tilt: current.tilt);
    BlocProvider.of<FreezeBloc>(context).dispatch(UNFREEZE(data));
    OSCActions().sendModule(ModuleType.GESTURE, jsonEncode(data));
  }

  /// Register tap action.
  sendPoint(context, LatLng point) {
    BlocProvider.of<PointBloc>(context).dispatch(TAP_EVENT(point, menu));
  }
}
