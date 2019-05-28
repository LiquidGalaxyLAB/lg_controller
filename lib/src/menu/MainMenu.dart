class MainMenu
{
  final String title;
  const MainMenu(this.title);
  static values()
  {
    return [HOME,TOURS,POI,GUIDE,OVERLAY ];
  }
  static const MainMenu HOME =const MainMenu("Home");
  static const MainMenu TOURS =const MainMenu("Tours");
  static const MainMenu POI =const MainMenu("POI");
  static const MainMenu GUIDE =const MainMenu("Guide");
  static const MainMenu OVERLAY =const MainMenu("Overlay");
}