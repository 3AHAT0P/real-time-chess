import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chess/models/main.dart';
import 'package:chess/utils/main.dart';

import 'package:chess/services/main.dart';

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


@immutable
class ExternalData extends Equatable {
  final Figure figure;
  final bool showCircle;

  ExternalData({ this.figure, this.showCircle });

  @override
  List<Object> get props => [figure, showCircle];
}

class CellWidget extends StatelessWidget {
  CellWidget({Key key, this.type, this.position}) : super(key: key);

  @required final CellType type;
  @required final CellCoordinate position;

  Widget _build(ExternalData data) {
    final List<Widget> stackChildren = [
      Center(child: Text('${this.position.toString()}', style: TextStyle(color: themeTextColors[type]))),
    ];

    if (data.figure != null) stackChildren.add(Center(child: FigureWidget(model: data.figure)));

    if (data.showCircle) stackChildren.add(Center(child: FractionallySizedBox(
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

  @override
  Widget build(BuildContext context) {
    return Selector<GameService, ExternalData>(
      selector: (_, gameService) => ExternalData(
        figure: gameService.figuresPlacement[position],
        showCircle: gameService.movePossiblePositions.containsKey(position),
      ),
      // shouldRebuild: (ExternalData a, ExternalData b) => a != b, // It's unnecessary in this case
      builder: (_, data, __) => _build(data),
    );
  }
}
