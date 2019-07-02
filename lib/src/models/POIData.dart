import 'package:lg_controller/src/models/KMLData.dart';

/// POI model for KML data.
class POIData extends KMLData {
  POIData(
      {String title,
      String desc,
      double latitude,
      double longitude,
      double bearing,
      double zoom,
      double tilt}) {
    KMLData(
        title: title,
        desc: desc,
        latitude: latitude,
        longitude: longitude,
        bearing: bearing,
        zoom: zoom,
        tilt: tilt);
  }

  /// Create [POIData] instance from JSON map.
  POIData.fromJson(Map<String, dynamic> json) {
    this.title = json['title'];
    this.desc = json['desc'];
    this.latitude = json['latitude'];
    this.longitude = json['longitude'];
    this.bearing = json['bearing'];
    this.zoom = json['zoom'];
    this.tilt = json['tilt'];
  }

  /// Convert [POIData] instance to JSON map.
  Map<String, dynamic> toJson() => {
        'title': title,
        'desc': desc,
        'latitude': latitude,
        'longitude': longitude,
        'bearing': bearing,
        'zoom': zoom,
        'tilt': tilt,
      };

  /// Convert [POIData] instance to database map.
  Map<String, dynamic> toDatabaseMap() => {
        'title': title,
        'desc': desc,
        'latitude': latitude,
        'longitude': longitude,
        'bearing': bearing,
        'zoom': zoom,
        'tilt': tilt,
        'count': 0,
      };

  /// Create [POIData] instance from database map.
  POIData.fromDatabaseMap(Map<String, dynamic> json) {
    this.title = json['title'];
    this.desc = json['desc'];
    this.latitude = json['latitude'];
    this.longitude = json['longitude'];
    this.bearing = json['bearing'];
    this.zoom = json['zoom'];
    this.tilt = json['tilt'];
    this.count = json['count'];
  }
}
