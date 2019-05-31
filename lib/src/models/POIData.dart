import 'package:lg_controller/src/models/KMLData.dart';

class POIData extends KMLData {
  POIData(String title, String desc) : super(title, desc);

  String getTitle() {
    return super.getTitle();
  }

  String getDesc() {
    return super.getDesc();
  }
}
