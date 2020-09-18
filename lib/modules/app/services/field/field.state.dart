part of 'field.bloc.dart';

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

abstract class FieldState {
  Map<CellCoordinate, Figure> figuresPlacement = new Map<CellCoordinate, Figure>.from(defaultFigurePlacement);

  CellCoordinate selectedIndex;
  Map<CellCoordinate, FigureAction> movePossiblePositions = new Map<CellCoordinate, FigureAction>();
}

class FieldInitial extends FieldState {
  
}
