class ModuleType {
  final int encoding;
  final String path;

  const ModuleType(this.encoding, this.path);

  static values() {
    return [GESTURE, FLYTO, POI];
  }

  static const ModuleType GESTURE = const ModuleType(0, "/gesture");
  static const ModuleType FLYTO = const ModuleType(1, "/flyto");
  static const ModuleType POI = const ModuleType(2, "/poi");
}
