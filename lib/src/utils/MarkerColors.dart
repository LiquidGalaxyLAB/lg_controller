
/// Menu items for Fly To menu dialog box.
class MarkerColors {
  final String title;
  final int value;

  const MarkerColors(this.title, this.value);

  static values() {
    return [RED, BLUE, GREEN];
  }

  static const MarkerColors RED = const MarkerColors("Red",0);
  static const MarkerColors BLUE = const MarkerColors("Blue",240);
  static const MarkerColors GREEN = const MarkerColors("Green",120);
}