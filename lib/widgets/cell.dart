import 'package:flutter/material.dart';

import 'package:chess/models/main.dart';
import 'package:chess/utils/main.dart';

import 'figure.dart';

enum CellType {
  white,
  black,
}

Map<CellType, Color> themeTextColors = {
  CellType.white: HSLColor.fromColor(Colors.black).withAlpha(.6).toColor(),
  CellType.black: HSLColor.fromColor(Colors.white).withAlpha(.6).toColor(),
};

Map<CellType, Color> themeBackColors = {
  CellType.white: Colors.white,
  CellType.black: Colors.black,
};

class CellWidget extends StatelessWidget {
  CellWidget({Key key, this.type, this.position, this.figure, this.showCircle}) : super(key: key);

  @required final CellType type;
  @required final CellCoordinate position;
  final Figure figure;
  final bool showCircle;

  @override
  Widget build(BuildContext context) {
    final List<Widget> stackChildren = [
      Center(child: Text('${this.position.toString()}', style: TextStyle(color: themeTextColors[this.type]))),
    ];
    if (figure != null) stackChildren.add(Center(child: FigureWidget(model: this.figure)));
    if (showCircle) stackChildren.add(Center(child: FractionallySizedBox(
      widthFactor: 0.3,
      heightFactor: 0.3,
      child: Container(
        decoration: new BoxDecoration(
          color: HSLColor.fromColor(Colors.red).withAlpha(.6).toColor(),
          shape: BoxShape.circle,
          border: Border.all(width: 1, color: Colors.white),
        ),
      )
    )));

    return Container(
      padding: const EdgeInsets.all(4),
      child: Stack(
        children: stackChildren,
      ),
      color: themeBackColors[this.type],
    );
  }
}