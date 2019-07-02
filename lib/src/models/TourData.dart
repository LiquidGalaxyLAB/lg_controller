import 'package:lg_controller/src/models/KMLData.dart';

/// Tour model for KML data.
class TourData extends KMLData {
  /// File id of the google drive file for the module data.
  String fileID = "";

  TourData(
      {String title,
      String desc,
      double latitude,
      double longitude,
      double bearing,
      double zoom,
      double tilt,
      int count,
      this.fileID}) {
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

  /// Create [TourData] instance from JSON map.
  TourData.fromJson(Map<String, dynamic> json) {
    this.title = json['title'];
    this.desc = json['desc'];
    this.latitude = json['latitude'];
    this.longitude = json['longitude'];
    this.bearing = json['bearing'];
    this.zoom = json['zoom'];
    this.tilt = json['tilt'];
    this.fileID = json['fileID'];
  }

  /// Convert [TourData] instance to JSON map.
  Map<String, dynamic> toJson() => {
        'title': title,
        'desc': desc,
        'latitude': latitude,
        'longitude': longitude,
        'bearing': bearing,
        'zoom': zoom,
        'tilt': tilt,
        'fileID': fileID,
      };

  /// Convert [TourData] instance to database map.
  Map<String, dynamic> toDatabaseMap() => {
        'title': title,
        'desc': desc,
        'latitude': latitude,
        'longitude': longitude,
        'bearing': bearing,
        'zoom': zoom,
        'tilt': tilt,
        'fileID': fileID,
        'count': 0,
      };

  /// Create [TourData] instance from database map.
  TourData.fromDatabaseMap(Map<String, dynamic> json) {
    this.title = json['title'];
    this.desc = json['desc'];
    this.latitude = json['latitude'];
    this.longitude = json['longitude'];
    this.bearing = json['bearing'];
    this.zoom = json['zoom'];
    this.tilt = json['tilt'];
    this.fileID = json['fileID'];
    this.count = json['count'];
  }
}
