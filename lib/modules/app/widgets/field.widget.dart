import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:chess/modules/app/services/field/field.bloc.dart';
import 'package:chess/utils/main.dart';

import 'cell.widget.dart';

class Field extends StatefulWidget {
  Field({Key key}) : super(key: key);

  @override
  _FieldState createState() => _FieldState();
}

class _FieldState extends ModularState<Field, FieldBloc> {
  Size _cellSize;

  _FieldState() {
    controller.listen((data) {
      debugPrint('!!!!!!!!!!!!, $data');
    });
  }

  CellCoordinate _normalizeCoordinates(Offset position) {
    final _x = position.dx ~/ _cellSize.width + 1;
    final _y = 8 - position.dy ~/ _cellSize.height;

    return new CellCoordinate(x: _x, y: _y);
  }

  void _updateCellSize(size) {
    setState(() => _cellSize = size);
  }

  Widget _buildCell(FieldItem item, bool isWhite) {
    final _figure = controller.state.figuresPlacement[item.position];
    debugPrint('_buildCell, ${controller.state.movePossiblePositions}');
    return Cell(
      key: item.key,
      type: isWhite ? CellType.white : CellType.black,
      position: item.position,
      figure: _figure,
      showCircle: controller.state.movePossiblePositions.containsKey(item.position),
    );
  }
  
  Widget _buildGrid() {
    var _isWhite = false;

    debugPrint('!!!!!!!!!!!1 _buildGrid');

    return GridView.count(
      crossAxisCount: 8,
      children: items.map((item) {
        if (item.position.x != 1) _isWhite = !_isWhite;
        return MeasureSize(
          child: _buildCell(item, _isWhite),
          onChange: _updateCellSize,
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {

    debugPrint('!!!!!!!!!!!1 build');
    return Listener(
      onPointerDown: (details) {
        controller.add(FieldFigureMoveStart(position: _normalizeCoordinates(details.localPosition)));
      },
      onPointerUp: (details) {
        controller.add(FieldFigureMoveEnd(position: _normalizeCoordinates(details.localPosition)));
      },
      child: _buildGrid(),
    );
  }
}