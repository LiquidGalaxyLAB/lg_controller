import 'package:lg_controller/src/models/OverlayItem.dart';
import 'package:lg_controller/src/models/PointData.dart';

/// Polygon data model class.
class PolygonData extends OverlayItem {
  /// Coordinates of the end points.
  List<PointData> points = List();

  /// Number of vertices of Polygon.
  int vertices;

  /// Width of the stroke.
  int width = 10;

  /// Color of the polygon.
  int color = 0xFF00FF00;

  bool complete=false;

  /// Color of the stroke.
  int strokeColor = 0xFF00FF00;

  PolygonData(id, title, desc, this.vertices) : super(id: id, title: title, desc: desc);

  /// Sets the end points in consecutive fashion.
  void setPoint(PointData data) {
    if(points.length<vertices)
      try {
        points.add(data);
      } catch (e) {
        print(e);
      }
    else
      complete=true;
  }

  /// Convert [PolygonData] instance to JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': 'Line',
      'points': points,
      'title': title,
      'desc': desc,
      'width': width,
      'color': color,
      'strokeColor': strokeColor,
    };
  }

  /// Create [PolygonData] instance from JSON map.
  PolygonData.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.points =
        (json['points'] as List).map((i) => PointData.fromJson(i)).toList();
    this.title = json['title'];
    this.desc = json['desc'];
    this.width = json['width'];
    this.color = json['color'];
    this.strokeColor = json['strokeColor'];
  }

  /// Give JSON map as string in toString override.
  @override
  String toString() {
    return toJson().toString();
  }
}
