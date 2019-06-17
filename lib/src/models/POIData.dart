import 'package:lg_controller/src/models/KMLData.dart';

/// POI model for KML data.
class POIData extends KMLData {
  POIData(String title, String desc) : super(title: title, desc: desc);

  String getTitle() {
    return super.getTitle();
  }

  String getDesc() {
    return super.getDesc();
  }
}
