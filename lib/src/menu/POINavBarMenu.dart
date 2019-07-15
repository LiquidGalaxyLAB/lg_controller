import 'package:lg_controller/src/ui/NavBar.dart';

/// Menu items for POI [NavBar].
class POINavBarMenu {
  final String title;

  const POINavBarMenu(this.title);

  static values() {
    return [
      RECENTLY_VIEWED,
      PRIVATE_1,
      CATEGORY_1,
      CATEGORY_2,
      CATEGORY_3,
      CATEGORY_4
    ];
  }

  static const POINavBarMenu RECENTLY_VIEWED = const POINavBarMenu("Recently_Viewed");
  static const POINavBarMenu PRIVATE_1 = const POINavBarMenu("Private");
  static const POINavBarMenu CATEGORY_1 = const POINavBarMenu("Category_1");
  static const POINavBarMenu CATEGORY_2 = const POINavBarMenu("Category_2");
  static const POINavBarMenu CATEGORY_3 = const POINavBarMenu("Category_3");
  static const POINavBarMenu CATEGORY_4 = const POINavBarMenu("Category_4");
}
