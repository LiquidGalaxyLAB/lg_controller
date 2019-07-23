import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lg_controller/src/blocs/FreezeBloc.dart';
import 'package:lg_controller/src/blocs/PointBloc.dart';
import 'package:lg_controller/src/menu/OverlayMenu.dart';
import 'package:lg_controller/src/models/KMLData.dart';
import 'package:lg_controller/src/models/LineData.dart';
import 'package:lg_controller/src/models/OverlayItem.dart';
import 'package:lg_controller/src/models/PlacemarkData.dart';
import 'package:lg_controller/src/osc/ModuleType.dart';
import 'package:lg_controller/src/osc/OSCActions.dart';
import 'package:lg_controller/src/states_events/OverlayActions.dart';
import 'package:lg_controller/src/states_events/PointActions.dart';
import 'package:lg_controller/src/ui/PropertiesDialog.dart';

/// Overlay (Google map view).
class OverlayMapView extends StatelessWidget {
  /// Controller for google map.
  GoogleMapController _controller;

  /// Current position of camera of the map.
  CameraPosition current;

  /// Markers of the google map.
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  /// Polyline of the google map.
  Map<PolylineId, Polyline> lines = <PolylineId, Polyline>{};

  /// Freeze state of the map.
  bool unfreeze = true;

  /// Currently selected overlay menu.
  OverlayMenu menu;

  OverlayMapView();

  Widget build(BuildContext context) {
    getInitialData();
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
                else if (state is ProcessingState) {
                  print((state.data as LineData).points[0].point);
                  if (state.data is LineData) {
                    markers[MarkerId(state.data.id)] = new Marker(
                      onTap: () => {},
                      consumeTapEvents: true,
                      markerId: MarkerId(state.data.id),
                      position: (state.data as LineData).points[0].point,
                      zIndex: 10,
                      icon: BitmapDescriptor.fromAsset("image_assets/place.png"),
                    );
                  }
                }
                else if (state is UninitializedState) {
                  markers = <MarkerId, Marker>{};
                  lines = <PolylineId, Polyline>{};
                  for (var i in state.data) {
                    if (i is PlacemarkData) {
                      markers[MarkerId((i as PlacemarkData).id)] = new Marker(
                        onTap: () => showDialog(
                            context: context,
                            builder: (BuildContext context2) {
                              return PropertiesDialog(
                                  i as PlacemarkData, OverlayMenu.ROUND_TEMP,
                                  (data) {
                                state.data.removeWhere((item) =>
                                    (item is PlacemarkData &&
                                        item.id == data.id));
                                state.data.add(data);
                                BlocProvider.of<PointBloc>(context)
                                    .dispatch(MODIFY_EVENT());
                              }, (data) {
                                state.data.removeWhere((item) =>
                                    (item is PlacemarkData &&
                                        item.id == data.id));
                                BlocProvider.of<PointBloc>(context)
                                    .dispatch(MODIFY_EVENT());
                              });
                            }),
                        consumeTapEvents: true,
                        markerId: MarkerId((i as PlacemarkData).id),
                        position: (i as PlacemarkData).point.point,
                        infoWindow: InfoWindow(
                          title: (i as PlacemarkData).title,
                          snippet: (i as PlacemarkData).desc,
                        ),
                        zIndex: (i as PlacemarkData).point.zInd,
                        icon: BitmapDescriptor.defaultMarkerWithHue(
                            (i as PlacemarkData).iconColor),
                      );
                    } else if (i is LineData) {
                      lines[PolylineId((i as LineData).id)] = new Polyline(
                        polylineId: PolylineId((i as LineData).id),
                        onTap: () => showDialog(
                            context: context,
                            builder: (BuildContext context2) {
                              return PropertiesDialog(
                                  i as LineData, OverlayMenu.LINE, (data) {
                                state.data.removeWhere((item) =>
                                    (item is LineData && item.id == data.id));
                                state.data.add(data);
                                BlocProvider.of<PointBloc>(context)
                                    .dispatch(MODIFY_EVENT());
                              }, (OverlayItem data) {
                                state.data.removeWhere((item) =>
                                    (item is LineData && item.id == data.id));
                                BlocProvider.of<PointBloc>(context)
                                    .dispatch(MODIFY_EVENT());
                              });
                            }),
                        consumeTapEvents: true,
                        points:
                            List<LatLng>.generate(2, (j) => i.points[j].point),
                        zIndex: i.points[0].zInd.toInt(),
                        width: i.width,
                        color: Color(i.color),
                      );
                    }
                  }
                }
                return GoogleMap(
                  rotateGesturesEnabled: unfreeze,
                  scrollGesturesEnabled: unfreeze,
                  tiltGesturesEnabled: unfreeze,
                  zoomGesturesEnabled: unfreeze,
                  onTap: (point) => sendPoint(context, point),
                  onMapCreated: (controller) =>
                      this._controller = controller,
                  onCameraMove: (cameraPosition) =>
                      this.current = cameraPosition,
                  onCameraIdle: () => changePosition(context),
                  mapType: MapType.satellite,
                  markers: Set<Marker>.of(markers.values),
                  polylines: Set<Polyline>.of(lines.values),
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
  getInitialData() async{
    String defData = (await SharedPreferences.getInstance()).getString('defaultData');
    await Future.delayed(Duration(seconds: 1));
    if (defData != null && _controller!=null) {
      KMLData initialData = KMLData.fromJson(jsonDecode(defData));
      _controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(initialData.latitude, initialData.longitude),
            zoom: initialData.zoom,
            tilt: initialData.tilt,
            bearing: initialData.bearing),
      ),);
    }
  }
}
