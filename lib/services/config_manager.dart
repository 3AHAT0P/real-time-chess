import 'package:chess/configs/base.dart';
import 'package:flutter/foundation.dart';

class ConfigManagerService with ChangeNotifier {
  final ApplicationConfig config;

  ConfigManagerService({ this.config }): super();
}
