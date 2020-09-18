import 'package:flutter/material.dart';

import 'package:flutter_modular/flutter_modular.dart';

import './pages/main.dart';
import './app.widget.dart';

// app_module.dart
class AppModule extends MainModule {

  // Provide a list of dependencies to inject into your project
  @override
  List<Bind> get binds => [];

  // Provide all the routes for your module
  @override
  List<ModularRouter> get routers => routes;

  // Provide the root widget associated with your module
  // In this case, it's the widget you created in the first step
  @override
  Widget get bootstrap => AppWidget();
}