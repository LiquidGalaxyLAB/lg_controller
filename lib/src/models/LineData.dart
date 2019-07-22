import 'package:lg_controller/src/models/OverlayItem.dart';
import 'package:lg_controller/src/models/PointData.dart';

/// Line data model class.
class LineData extends OverlayItem {
  /// Coordinates of the end points.
  List<PointData> points = List(2);

  /// Width of the line.
  int width = 10;

  /// Color of the line.
  int color = 0xFFFF00FF;

  LineData(id, title, desc) : super(id: id, title: title, desc: desc);

  /// Sets the end points in consecutive fashion.
  void setPoint(PointData data) {
    try {
      points[points.indexWhere((data) => data == null)] = data;
    } catch (e) {
      print(e);
    }
  }

  /// Convert [LineData] instance to JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': 'Line',
      'points': points,
      'title': title,
      'desc': desc,
      'width': width,
      'color': color,
    };
  }

  /// Create [LineData] instance from JSON map.
  LineData.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.points =
        (json['points'] as List).map((i) => PointData.fromJson(i)).toList();
    this.title = json['title'];
    this.desc = json['desc'];
    this.width = json['width'];
    this.color = json['color'];
  }

  /// Give JSON map as string in toString override.
  @override
  String toString() {
    return toJson().toString();
  }
}
