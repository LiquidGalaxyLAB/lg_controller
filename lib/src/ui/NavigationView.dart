import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lg_controller/src/models/KMLData.dart';
import 'package:lg_controller/src/osc/ModuleType.dart';
import 'package:lg_controller/src/osc/OSCActions.dart';

class NavigationView extends StatelessWidget {
  Completer<GoogleMapController> _controller = Completer();
  CameraPosition current;
  KMLData initialData;

  NavigationView(this.initialData);

  Widget build(BuildContext context) {
    Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
    if (initialData == null) {
      initialData = new KMLData(
          title: "Default",
          desc: "default",
          latitude: 0,
          longitude: 0,
          bearing: 0,
          zoom: 0,
          tilt: 0);
      markers.clear();
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
              width: 240,
              height: 120,
              child: Card(
                  child: GoogleMap(
                    onMapCreated: (controller) =>
                        _controller.complete(controller),
                    onCameraMove: (cameraPosition) =>
                        this.current = cameraPosition,
                    onCameraIdle: () => changePosition(),
                    mapType: MapType.satellite,
                    markers: Set<Marker>.of(markers.values),
                    initialCameraPosition: CameraPosition(
                      target:
                          LatLng(initialData.getLat(), initialData.getLgt()),
                      bearing: initialData.getBearing(),
                      zoom: initialData.getZoom(),
                      tilt: initialData.getTilt(),
                    ),
                  ),
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
}
