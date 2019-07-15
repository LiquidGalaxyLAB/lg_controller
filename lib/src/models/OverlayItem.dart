import 'package:equatable/equatable.dart';
import 'package:lg_controller/src/models/PlacemarkData.dart';

/// Overlay feature data model class.
abstract class OverlayItem extends Equatable {
  /// Convert [OverlayItem] instance to JSON map.
  Map<String, dynamic> toJson();

  /// Create [OverlayItem] instance from JSON map.
  static OverlayItem fromJson(Map<String, dynamic> json) {
    if ((json['type'] as String).compareTo('Placemark') == 0)
      return PlacemarkData.fromJson(json);
    return null;
  }
}
