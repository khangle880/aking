import 'dart:collection';

import 'package:aking/logic/models/walkthrough.dart';

class WalkthroughCache {
  var _index = -1;

  static const List<Walkthrough> _walkthroughs = [
    Walkthrough("Welcome to aking", "Whats going to happen tomorrow?",
        "assets/images/walkthrough1.svg", "#F96060"),
    Walkthrough("Work happens", "Get notified when work happens.",
        "assets/images/walkthrough2.svg", "#6074F9"),
    Walkthrough("Tasks and assign", "Task and assign them to colleagues.",
        "assets/images/walkthrough3.svg", "#8560F9"),
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
