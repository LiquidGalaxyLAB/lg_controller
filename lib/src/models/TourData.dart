import 'package:lg_controller/src/models/KMLData.dart';

/// Tour model for KML data.
class TourData extends KMLData {
  TourData(String title, String desc) : super(title: title, desc: desc);

  String getTitle() {
    return super.getTitle();
  }

  String getDesc() {
    return super.getDesc();
  }
}
