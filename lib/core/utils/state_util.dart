import 'package:flutter/material.dart';

class Get {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static get currentContext {
    return navigatorKey.currentContext;
  }

  static double get width {
    return MediaQuery.of(currentContext).size.width;
  }

  static double get height {
    return MediaQuery.of(currentContext).size.height;
  }
}
