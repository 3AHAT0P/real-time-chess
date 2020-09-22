import 'package:flutter/widgets.dart';

import 'package:chess/models/main.dart';
import 'package:chess/utils/main.dart';

Map<CellCoordinate, Figure> _defaultFigurePlacement = {
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

final _buildDefaultFigurePlacement = () => new Map<CellCoordinate, Figure>.from(_defaultFigurePlacement);

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

class GameService with ChangeNotifier {
  Map<CellCoordinate, Figure> _figuresPlacement = _buildDefaultFigurePlacement();

  CellCoordinate _selectedIndex;
  Map<CellCoordinate, FigureAction> _movePossiblePositions = new Map<CellCoordinate, FigureAction>();

  Map<CellCoordinate, Figure> get figuresPlacement => _figuresPlacement;
  CellCoordinate get selectedIndex => _selectedIndex;
  Map<CellCoordinate, FigureAction> get movePossiblePositions => _movePossiblePositions;

  void startMove(CellCoordinate position) {
    if (_selectedIndex != null) return;

    final _figure = _figuresPlacement[position];
    if (_figure == null) return;

    _selectedIndex = position;
    _movePossiblePositions = _figure.getPossibleCells(position, _figuresPlacement);

    notifyListeners();
  }

  void endMove(CellCoordinate position) {
    if (_selectedIndex == null) return;

    if (position == _selectedIndex) return;

    if (_movePossiblePositions.containsKey(position)) {
      _figuresPlacement[position] = _figuresPlacement[_selectedIndex];
      _figuresPlacement.remove(_selectedIndex);
    }

    _selectedIndex = null;
    _movePossiblePositions = new Map<CellCoordinate, FigureAction>();

    notifyListeners();
  }

  void newGame() {
    _figuresPlacement = _buildDefaultFigurePlacement();
    _selectedIndex = null;
    _movePossiblePositions = new Map<CellCoordinate, FigureAction>();

    notifyListeners();
  }
}
