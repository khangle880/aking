extension ExpandedString on String {
  String simplify() {
    return replaceAll(RegExp(r'\n\s*\n'), '');
  }
}
