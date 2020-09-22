import 'package:flutter/material.dart';

import 'package:chess/configs/base.dart';
import 'package:chess/utils/main.dart';

import 'app.dart';

void main() {
  Logger(environment: Environment.development);
  runApp(AppWidget(config: ApplicationConfig(Environment.development)));
}
