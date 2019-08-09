import 'package:equatable/equatable.dart';
import 'package:lg_controller/src/models/LineData.dart';
import 'package:lg_controller/src/models/imageData.dart';
import 'package:lg_controller/src/models/PolygonData.dart';
import 'package:lg_controller/src/models/PlacemarkData.dart';

/// Overlay feature data model class.
abstract class OverlayItem extends Equatable {
  /// ID of the overlay feature.
  String id;

  /// Title of the overlay feature.
  String title;

  /// Description of the overlay feature.
  String desc;

  OverlayItem({this.id, this.title, this.desc});

  /// Convert [OverlayItem] instance to JSON map.
  Map<String, dynamic> toJson();

  /// Create [OverlayItem] instance from JSON map.
  static OverlayItem fromJson(Map<String, dynamic> json) {
    if ((json['type'] as String).compareTo('Placemark') == 0)
      return PlacemarkData.fromJson(json);
    else if ((json['type'] as String).compareTo('Line') == 0)
      return LineData.fromJson(json);
    else if ((json['type'] as String).compareTo('Image') == 0)
      return ImageData.fromJson(json);
    else if ((json['type'] as String).compareTo('Polygon') == 0)
      return PolygonData.fromJson(json);
    return null;
  }
}
