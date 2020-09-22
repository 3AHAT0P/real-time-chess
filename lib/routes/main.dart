import 'package:flutter/widgets.dart';

import 'home.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final routes = {
  '/': (BuildContext context) => HomePage(title: 'Real Realtime Chess')
};
