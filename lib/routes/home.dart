import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chess/services/main.dart';
import 'package:chess/widgets/main.dart';

class HomePage extends StatelessWidget {
  final String title;

  HomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: FieldWidget(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.read<GameService>().newGame(),
        tooltip: 'Start new game',
        icon: const Icon(Icons.add),
        label: const Text('Start new game'),
      ),
    );
  }
}
