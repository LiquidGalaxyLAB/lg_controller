
/// Menu items for Fly To menu dialog box.
class LineColors {
  final String title;
  final int value;

  const LineColors(this.title, this.value);

  static values() {
    return [RED, BLUE, GREEN];
  }

  static const LineColors RED = const LineColors("Red",0xFFFF0000);
  static const LineColors BLUE = const LineColors("Blue",0xFF0000FF);
  static const LineColors GREEN = const LineColors("Green",0xFF00FF00);
}
