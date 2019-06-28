class SizeScaling {
  static double widthFactor = 1;
  static double heightFactor = 1;

  static setWidthScaling(double widthFactor) {
    SizeScaling.widthFactor = widthFactor;
  }

  static getWidthScaling() {
    return widthFactor;
  }

  static setHeightScaling(double heightFactor) {
    SizeScaling.heightFactor = heightFactor;
  }

  static getHeightScaling() {
    return heightFactor;
  }
}
