class BaseSize {
  static BaseSize? _instance;
  final double screenWidthBase;
  final double screenHeightBase;

  factory BaseSize(double screenWidthBase, double screenHeightBase) {
    _instance ??= BaseSize._(screenWidthBase, screenHeightBase);
    return _instance!;
  }

  BaseSize._(this.screenWidthBase, this.screenHeightBase);
}
