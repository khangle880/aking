import 'dart:collection';

import 'package:aking/global/constants/assets_path.dart';
import 'package:aking/logic/models/walkthrough.dart';

class WalkthroughCache {
  var _index = -1;

  static const List<Walkthrough> _walkthroughs = [
    Walkthrough("Welcome to aking", "Whats going to happen tomorrow?",
        walkthroughSvgImage1, "#F96060"),
    Walkthrough("Work happens", "Get notified when work happens.",
        walkthroughSvgImage2, "#6074F9"),
    Walkthrough("Tasks and assign", "Task and assign them to colleagues.",
        walkthroughSvgImage3, "#8560F9"),
  ];

  void addItem(Walkthrough item) {
    _walkthroughs.add(item);
  }

  set item(int index) {
    if (index >= 0 && index < _walkthroughs.length) {
      _index = index;
    }
  }

  int get item => _index;

  UnmodifiableListView<Walkthrough> get list =>
      UnmodifiableListView<Walkthrough>(_walkthroughs);
}
