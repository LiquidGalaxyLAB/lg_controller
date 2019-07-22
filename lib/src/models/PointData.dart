import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Point data model class.
class PointData {
  /// Coordinates of the point.
  LatLng point;

  /// Z index of the point.
  double zInd;

  PointData(this.point, this.zInd);

  /// Convert [PointData] instance to JSON map.
  Map<String, dynamic> toJson() {
    return {
      'latitude': point.latitude,
      'longitude': point.longitude,
      'zInd': zInd,
    };
  }

  /// Create [PointData] instance from JSON map.
  PointData.fromJson(Map<String, dynamic> json) {
    this.point = LatLng(json['latitude'], json['longitude']);
    this.zInd = json['zInd'];
  }

  /// Give JSON map as string in toString override.
  @override
  String toString() {
    return toJson().toString();
  }
}
