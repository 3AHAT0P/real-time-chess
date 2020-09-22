import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';

import 'package:chess/services/main.dart';
import 'package:chess/utils/main.dart';

import 'cell.dart';

class FieldWidget extends StatefulWidget {
  FieldWidget({Key key}) : super(key: key);

  @override
  _FieldState createState() => _FieldState();
}

class _FieldState extends State<FieldWidget> {
  Size _cellSize;

  CellCoordinate _normalizeCoordinates(Offset position) {
    final _x = position.dx ~/ _cellSize.width + 1;
    final _y = 8 - position.dy ~/ _cellSize.height;

    return new CellCoordinate(x: _x, y: _y);
  }

  void _updateCellSize(size) {
    setState(() => _cellSize = size);
  }

  Widget _buildCell(FieldItem item, bool isWhite) {
    final _figure = context.watch<GameService>().figuresPlacement[item.position];

    return CellWidget(
      key: item.key,
      type: isWhite ? CellType.white : CellType.black,
      position: item.position,
      figure: _figure,
      showCircle: context.watch<GameService>().movePossiblePositions.containsKey(item.position),
    );
  }
  
  Widget _buildGrid() {
    var _isWhite = false;

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
    return Listener(
      onPointerDown: (details) {
        context.read<GameService>().startMove(_normalizeCoordinates(details.localPosition));
      },
      onPointerUp: (details) {
        context.read<GameService>().endMove(_normalizeCoordinates(details.localPosition));
      },
      child: _buildGrid(),
    );
  }
}