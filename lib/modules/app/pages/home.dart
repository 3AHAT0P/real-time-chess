import 'package:chess/modules/app/app.module.dart';
import 'package:chess/modules/app/services/field/field.bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../widgets/field.widget.dart';

class HomePage extends ModularStatelessWidget<AppModule> {
  final String title;

  HomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Field(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Modular.get<FieldBloc>().add(FieldCreateNewGame()),
        tooltip: 'Start new game',
        icon: const Icon(Icons.add),
        label: const Text('Start new game'),
      ),
    );
  }
}
