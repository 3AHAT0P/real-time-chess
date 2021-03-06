import 'package:chess/configs/base.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'services/main.dart';
import 'routes/main.dart';

class AppWidget extends StatelessWidget {
  final ApplicationConfig config;

  AppWidget({ Key key, @required this.config }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ConfigManagerService(config: config)),
        ChangeNotifierProvider(create: (_) => GameService()),
      ],
      child: _AppWidget(),
    );
  }
}

class _AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RRC',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      navigatorKey: navigatorKey,
      routes: routes,
    );
  }
}