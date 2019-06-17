import 'package:lg_controller/src/ui/NavBar.dart';

/// Menu items for [NavBar].
class NavBarMenu {
  final String title;

  const NavBarMenu(this.title);

  static values() {
    return [
      RECENTLY_VIEWED,
      CATEGORY_1,
      CATEGORY_2,
      CATEGORY_3,
      CATEGORY_4,
      CATEGORY_5
    ];
  }

  static const NavBarMenu RECENTLY_VIEWED = const NavBarMenu("Recently_Viewed");
  static const NavBarMenu CATEGORY_1 = const NavBarMenu("Category_1");
  static const NavBarMenu CATEGORY_2 = const NavBarMenu("Category_2");
  static const NavBarMenu CATEGORY_3 = const NavBarMenu("Category_3");
  static const NavBarMenu CATEGORY_4 = const NavBarMenu("Category_4");
  static const NavBarMenu CATEGORY_5 = const NavBarMenu("Category_5");
}
