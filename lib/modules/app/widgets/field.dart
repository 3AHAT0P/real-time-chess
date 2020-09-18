import 'package:chess/utils/measure_size.dart';
import 'package:flutter/material.dart';

import 'package:flutter/gestures.dart';

import 'package:chess/utils/cell_coordinate.dart';

import 'cell.dart';
import 'figure/figure.dart';

Map<CellCoordinate, Figure> defaultFigurePlacement = {
  CellCoordinate.fromString('A1'): new Rook(color: FigureColor.white),
  CellCoordinate.fromString('B1'): new Knight(color: FigureColor.white),
  CellCoordinate.fromString('C1'): new Bishop(color: FigureColor.white),
  CellCoordinate.fromString('D1'): new King(color: FigureColor.white),
  CellCoordinate.fromString('E1'): new Queen(color: FigureColor.white),
  CellCoordinate.fromString('F1'): new Bishop(color: FigureColor.white),
  CellCoordinate.fromString('G1'): new Knight(color: FigureColor.white),
  CellCoordinate.fromString('H1'): new Rook(color: FigureColor.white),

  CellCoordinate.fromString('A2'): new Pawn(color: FigureColor.white),
  CellCoordinate.fromString('B2'): new Pawn(color: FigureColor.white),
  CellCoordinate.fromString('C2'): new Pawn(color: FigureColor.white),
  CellCoordinate.fromString('D2'): new Pawn(color: FigureColor.white),
  CellCoordinate.fromString('E2'): new Pawn(color: FigureColor.white),
  CellCoordinate.fromString('F2'): new Pawn(color: FigureColor.white),
  CellCoordinate.fromString('G2'): new Pawn(color: FigureColor.white),
  CellCoordinate.fromString('H2'): new Pawn(color: FigureColor.white),

  CellCoordinate.fromString('A7'): new Pawn(color: FigureColor.black),
  CellCoordinate.fromString('B7'): new Pawn(color: FigureColor.black),
  CellCoordinate.fromString('C7'): new Pawn(color: FigureColor.black),
  CellCoordinate.fromString('D7'): new Pawn(color: FigureColor.black),
  CellCoordinate.fromString('E7'): new Pawn(color: FigureColor.black),
  CellCoordinate.fromString('F7'): new Pawn(color: FigureColor.black),
  CellCoordinate.fromString('G7'): new Pawn(color: FigureColor.black),
  CellCoordinate.fromString('H7'): new Pawn(color: FigureColor.black),

  CellCoordinate.fromString('A8'): new Rook(color: FigureColor.black),
  CellCoordinate.fromString('B8'): new Knight(color: FigureColor.black),
  CellCoordinate.fromString('C8'): new Bishop(color: FigureColor.black),
  CellCoordinate.fromString('D8'): new King(color: FigureColor.black),
  CellCoordinate.fromString('E8'): new Queen(color: FigureColor.black),
  CellCoordinate.fromString('F8'): new Bishop(color: FigureColor.black),
  CellCoordinate.fromString('G8'): new Knight(color: FigureColor.black),
  CellCoordinate.fromString('H8'): new Rook(color: FigureColor.black),
};

class FieldItem {
  FieldItem({ this.position, this.key });

  final Key key;
  final CellCoordinate position;
}

List<FieldItem> items = List.generate(64, (index) {
  return FieldItem(
    position: new CellCoordinate(x: index % 8 + 1, y: 8 - index ~/ 8),
    key: UniqueKey(),
  );
});

class Field extends StatefulWidget {
  Field({Key key}) : super(key: key);

  @override
  _FieldState createState() => _FieldState();
}

class _FieldState extends State<Field> {
  Size _cellSize;
  Map<CellCoordinate, Figure> figuresPlacement = new Map<CellCoordinate, Figure>.from(defaultFigurePlacement);

  CellCoordinate selectedIndex;
  Map<CellCoordinate, FigureAction> movePossiblePositions = new Map<CellCoordinate, FigureAction>();

  CellCoordinate _normalizeCoordinates(Offset position) {
    final _x = position.dx ~/ _cellSize.width + 1;
    final _y = 8 - position.dy ~/ _cellSize.height;

    return new CellCoordinate(x: _x, y: _y);
  }

  void _startMove(Offset position) {
    if (selectedIndex != null) return;
    final _position = _normalizeCoordinates(position);
    final _figure = figuresPlacement[_position];
    if (_figure == null) return;
    setState(() {
      selectedIndex = _position;
      movePossiblePositions = _figure.getPossibleCells(_position, figuresPlacement);
    });
  }

  void _endMove(Offset position) {
    final _position = _normalizeCoordinates(position);

    if (selectedIndex == null) return;
    if (_position == selectedIndex) return;
    if (!movePossiblePositions.containsKey(_position)) {
      setState(() {
        selectedIndex = null;
        movePossiblePositions = new Map<CellCoordinate, FigureAction>();
      });
      return;
    }

    setState(() {
      figuresPlacement[_position] = figuresPlacement[selectedIndex];
      figuresPlacement.remove(selectedIndex);
      selectedIndex = null;
      movePossiblePositions = new Map<CellCoordinate, FigureAction>();
    });
  }

  void _updateCellSize(size) {
    setState(() => _cellSize = size);
  }

  Widget _buildCell(FieldItem item, bool isWhite) {
    final _figure = figuresPlacement[item.position];

    return Cell(
      key: item.key,
      type: isWhite ? CellType.white : CellType.black,
      position: item.position,
      figure: _figure,
      showCircle: movePossiblePositions.containsKey(item.position),
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
        _startMove(details.localPosition);
      },
      onPointerUp: (details) {
        _endMove(details.localPosition);
      },
      child: _buildGrid(),
    );
  }
}