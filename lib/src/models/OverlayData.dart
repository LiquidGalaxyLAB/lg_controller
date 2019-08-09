import 'dart:convert';

import 'package:lg_controller/src/models/KMLData.dart';
import 'package:lg_controller/src/models/OverlayItem.dart';

/// Overlay featues model for KML data.
class OverlayData extends KMLData {
  /// List of overlay features.
  List<OverlayItem> itemData;

  OverlayData(
      {String title,
      String desc,
      double latitude,
      double longitude,
      double bearing,
      double zoom,
      double tilt,
      int count,
      this.itemData}) {
    KMLData(
        title: title,
        desc: desc,
        latitude: latitude,
        longitude: longitude,
        bearing: bearing,
        zoom: zoom,
        tilt: tilt,
        count: count);
  }

  /// Create [OverlayData] instance from [KMLData].
  OverlayData.fromKMLData(KMLData data) {
    this.title = data.getTitle();
    this.desc = data.getDesc();
    this.latitude = data.getLat();
    this.longitude = data.getLgt();
    this.bearing = data.getBearing();
    this.zoom = data.getZoom();
    this.tilt = data.getTilt();
    this.itemData = [];
    this.imageUrl = data.imageUrl;
  }

  /// Create [OverlayData] instance from JSON map.
  OverlayData.fromJson(Map<String, dynamic> json) {
    this.title = json['title'];
    this.desc = json['desc'];
    this.latitude = json['latitude'];
    this.longitude = json['longitude'];
    this.bearing = json['bearing'];
    this.zoom = json['zoom'];
    this.tilt = json['tilt'];
    var items = json['itemData'] as List;
    this.itemData = items.map((i) => OverlayItem.fromJson(i)).toList();
    this.imageUrl = json['imageUrl'];
  }

  /// Convert [OverlayData] instance to JSON map.
  Map<String, dynamic> toJson() => {
        'title': title,
        'desc': desc,
        'latitude': latitude,
        'longitude': longitude,
        'bearing': bearing,
        'zoom': zoom,
        'tilt': tilt,
        'imageUrl': imageUrl,
        'itemData': itemData,
      };

  /// Convert [OverlayData] instance to database map.
  Map<String, dynamic> toDatabaseMap() => {
        'title': title,
        'desc': desc,
        'latitude': latitude,
        'longitude': longitude,
        'bearing': bearing,
        'zoom': zoom,
        'tilt': tilt,
        'itemData': jsonEncode(itemData),
        'count': 0,
        'imageUrl': imageUrl,
      };

  /// Create [OverlayData] instance from database map.
  OverlayData.fromDatabaseMap(Map<String, dynamic> json) {
    this.title = json['title'];
    this.desc = json['desc'];
    this.latitude = json['latitude'];
    this.longitude = json['longitude'];
    this.bearing = json['bearing'];
    this.zoom = json['zoom'];
    this.tilt = json['tilt'];
    this.imageUrl = json['imageUrl'];
    try {
      var items = jsonDecode(json['itemData']) as List;
      this.itemData = items.map((i) => OverlayItem.fromJson(i)).toList();
    } catch (e) {
      print(e.toString());
    }
    this.count = json['count'];
  }
}
