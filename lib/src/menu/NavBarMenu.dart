class NavBarMenu
{
  final String title;
  const NavBarMenu(this.title);
  static values()
  {
    return [RECENTLY_VIEWED,CATEGORY_1,CATEGORY_2,CATEGORY_3,CATEGORY_4,CATEGORY_5 ];
  }
  static const NavBarMenu RECENTLY_VIEWED =const NavBarMenu("Recently Viewed");
  static const NavBarMenu CATEGORY_1 =const NavBarMenu("Category 1");
  static const NavBarMenu CATEGORY_2 =const NavBarMenu("Category 2");
  static const NavBarMenu CATEGORY_3 =const NavBarMenu("Category 3");
  static const NavBarMenu CATEGORY_4 =const NavBarMenu("Category 4");
  static const NavBarMenu CATEGORY_5 =const NavBarMenu("Category 5");
}