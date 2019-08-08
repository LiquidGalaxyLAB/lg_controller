import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lg_controller/src/models/KMLData.dart';
import 'package:lg_controller/src/models/LineData.dart';
import 'package:lg_controller/src/models/OverlayData.dart';
import 'package:lg_controller/src/models/OverlayItem.dart';
import 'package:lg_controller/src/models/PlacemarkData.dart';
import 'package:lg_controller/src/osc/ModuleType.dart';
import 'package:lg_controller/src/osc/OSCActions.dart';
import 'package:lg_controller/src/utils/SizeScaling.dart';

/// Navigation view (Google map view) for home screen.
class NavigationView extends StatelessWidget {
  
  /// Controller for google map.
  GoogleMapController controller;

  /// Current position of camera of the map.
  CameraPosition current;

  /// KML data to be displayed.
  KMLData initialData;

  NavigationView(this.initialData);

  Widget build(BuildContext context) {
    Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
    Map<PolylineId, Polyline> lines = <PolylineId, Polyline>{};
    if (initialData == null) {
      initialData = new KMLData(
          title: "Default",
          desc: "default",
          latitude: 0,
          longitude: 0,
          bearing: 0,
          zoom: 0,
          tilt: 0);
      getInitialData();
      markers.clear();
    } else if (initialData is OverlayData) {
      for (OverlayItem i in (initialData as OverlayData).itemData) {
        if (i is PlacemarkData) {
          markers[MarkerId(i.id)] = new Marker(
            markerId: MarkerId(i.id),
            position: (i as PlacemarkData).point.point,
            infoWindow: InfoWindow(
              title: (i as PlacemarkData).title,
              snippet: (i as PlacemarkData).desc,
            ),
            zIndex: (i as PlacemarkData).point.zInd,
            icon: BitmapDescriptor.defaultMarkerWithHue(
                (i as PlacemarkData).iconColor.toDouble()),
          );
        } else if (i is LineData) {
          lines[PolylineId((i as LineData).id)] = new Polyline(
            polylineId: PolylineId((i as LineData).id),
            points: List<LatLng>.generate(2, (j) => i.points[j].point),
            zIndex: i.points[0].zInd.toInt(),
            width: i.width,
            color: Color(i.color),
          );
        }
      }
    } else {
      markers[MarkerId(initialData.toString())] = new Marker(
        markerId: MarkerId(initialData.toString()),
        position: LatLng(initialData.getLat(), initialData.getLgt()),
        infoWindow: InfoWindow(
          title: initialData.getTitle(),
          snippet: initialData.getDesc(),
        ),
        icon:
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
      );
    }
    return Container(
      padding: new EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 8,
          ),
          Hero(
            tag: "Nav_view",
            child: SizedBox(
              width: 240 * SizeScaling.getWidthScaling(),
              height: 120 * SizeScaling.getHeightScaling(),
              child: Card(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: GoogleMap(
                      onMapCreated: (controller) =>
                          this.controller=controller,
                      onCameraMove: (cameraPosition) =>
                          this.current = cameraPosition,
                      onCameraIdle: () => changePosition(),
                      mapType: MapType.satellite,
                      markers: Set<Marker>.of(markers.values),
                      polylines: Set<Polyline>.of(lines.values),
                      initialCameraPosition: CameraPosition(
                        target:
                            LatLng(initialData.getLat(), initialData.getLgt()),
                        bearing: initialData.getBearing(),
                        zoom: initialData.getZoom(),
                        tilt: initialData.getTilt(),
                      ),
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                  color: Colors.white70),
            ),
          ),
          SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }

  /// Initiate OSC action on change in camera position.
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
  }
  getInitialData() async{
    String defData = (await SharedPreferences.getInstance()).getString('defaultData');
    await Future.delayed(Duration(seconds: 1));
    if (defData != null && controller!=null) {
      initialData = KMLData.fromJson(jsonDecode(defData));
      controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(initialData.latitude, initialData.longitude),
            zoom: initialData.zoom,
        tilt: initialData.tilt,
        bearing: initialData.bearing),
      ),);
    }
  }
}
