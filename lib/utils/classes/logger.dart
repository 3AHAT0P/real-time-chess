import 'package:flutter/foundation.dart';

import 'package:chess/configs/base.dart';

class _DummyLogger implements Logger {
  void log(List<dynamic> args) { }
}

class _DevelopmentLogger implements Logger {
  void log(List<dynamic> args) {
    debugPrint('$args');
  }
}

/// Log variables with any type
/// 
/// Example:
/// ```
/// import 'package:chess/utils/classes/logger.dart';
/// 
/// class X {}
/// Logger().log([{'q': 1}, 1, 2, 'asdasd', X, X()]); // [{q: 1}, 1, 2, asdasd, X, Instance of 'X']
/// ```

abstract class Logger {
  static Logger _instance;

  factory Logger({ Environment environment }) {
    if (_instance == null) {
      if (environment == Environment.development) _instance = new _DevelopmentLogger();
      else _instance = new _DummyLogger();
    }
    return _instance;
  }

  void log(List<dynamic> args);
}