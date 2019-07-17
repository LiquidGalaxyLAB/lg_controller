import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lg_controller/src/models/OverlayItem.dart';

/// Placemark data model class.
class PlacemarkData extends OverlayItem {
  /// Coordinates of the point.
  LatLng point;

  /// ID of the placemark.
  String id;

  String title;
  String desc;
  double zInd;
  int iconSize = 3;
  double iconColor = BitmapDescriptor.hueMagenta;

  PlacemarkData(this.point, this.id, this.title, this.desc, this.zInd);

  /// Convert [PlacemarkData] instance to JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': 'Placemark',
      'latitude': point.latitude,
      'longitude': point.longitude,
      'title': title,
      'desc': desc,
      'zInd': zInd,
      'iconSize': iconSize,
      'iconColor': iconColor,
    };
  }

  /// Create [PlacemarkData] instance from JSON map.
  PlacemarkData.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.point = LatLng(json['latitude'], json['longitude']);
    this.title = json['title'];
    this.desc = json['desc'];
    this.zInd = json['zInd'];
    this.iconSize = json['iconSize'];
    this.iconColor = json['iconColor'];
  }

  /// Give JSON map as string in toString override.
  @override
  String toString() {
    return toJson().toString();
  }
}
