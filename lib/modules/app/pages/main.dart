import 'package:flutter_modular/flutter_modular.dart';

import 'home.dart';

final routes = [
  ModularRouter('/', child: (context, args) => HomePage(title: 'Real Realtime Chess')),
];