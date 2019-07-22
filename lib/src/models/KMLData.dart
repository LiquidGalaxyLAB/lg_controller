import 'package:equatable/equatable.dart';

/// Base model for KML data.
class KMLData extends Equatable {
  /// Title of the module data.
  String title = "";

  /// Description of the module data.
  String desc = "";

  /// Latitude of the module data.
  double latitude = 0;

  /// Longitude of the module data.
  double longitude = 0;

  /// Bearing of the module data.
  double bearing = 0;

  /// Zoom of the module data.
  double zoom = 0;

  /// Tilt of the module data.
  double tilt = 0;

  /// Count of the module data which denotes the no. of times a module has been viewed.
  int count = 0;

  /// Url of the image for the KML module.
  String imageUrl = "";

  KMLData(
      {this.title,
      this.desc,
      this.latitude,
      this.longitude,
      this.bearing,
      this.zoom,
      this.tilt,
      this.count,
      this.imageUrl});

  getTitle() {
    return title;
  }

  getDesc() {
    return desc;
  }

  getLat() {
    return latitude;
  }

  getLgt() {
    return longitude;
  }

  getBearing() {
    return bearing;
  }

  getZoom() {
    return zoom;
  }

  getTilt() {
    return tilt;
  }

  /// Create [KMLData] instance from JSON map.
  KMLData.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        desc = json['desc'],
        latitude = json['latitude'],
        longitude = json['longitude'],
        bearing = json['bearing'],
        zoom = json['zoom'],
        tilt = json['tilt'],
        imageUrl = json['imageUrl'];

  /// Convert [KMLData] instance to JSON map.
  Map<String, dynamic> toJson() => {
        'title': title,
        'desc': desc,
        'latitude': latitude,
        'longitude': longitude,
        'bearing': bearing,
        'zoom': zoom,
        'tilt': tilt,
        'imageUrl': imageUrl,
      };

  /// Convert [KMLData] instance to database map.
  Map<String, dynamic> toDatabaseMap() => {
        'title': title,
        'desc': desc,
        'latitude': latitude,
        'longitude': longitude,
        'bearing': bearing,
        'zoom': zoom,
        'tilt': tilt,
        'count': 0,
        'imageUrl': imageUrl,
      };

  /// Create [KMLData] instance from database map.
  KMLData.fromDatabaseMap(Map<String, dynamic> json)
      : title = json['title'],
        desc = json['desc'],
        latitude = json['latitude'],
        longitude = json['longitude'],
        bearing = json['bearing'],
        zoom = json['zoom'],
        tilt = json['tilt'],
        count = json['count'],
        imageUrl = json['imageUrl'];
}
