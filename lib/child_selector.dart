import 'package:flutter/widgets.dart';

import 'models/child.dart';

class ChildSelector {
  static final ChildSelector _instance = ChildSelector._internal();
  late ValueNotifier<Child?> child;

  factory ChildSelector() {
    return _instance;
  }

  ChildSelector._internal() {
    child = ValueNotifier<Child?>(null);
  }
}
