import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:chess/utils/classes/cell_coordinate.dart';

enum FigureColor {
  black,
  white,
}

enum FigureType {
  pawn,
  knight,
  bishop,
  rook,
  queen,
  king,
}

enum FigureAction {
  move,
  attack,
  transform,
}

@immutable
abstract class Figure extends Equatable {
  final FigureColor color;
  final FigureType type;
  
  Figure({@required this.type, @required this.color});

  Map<CellCoordinate, FigureAction> getPossibleCells(CellCoordinate current, Map<CellCoordinate, Figure> figuresPlacement);

  @override
  List<Object> get props => [type, color];
}

class Pawn extends Figure {
  final int yModificator;

  Pawn({FigureColor color}):
    yModificator = color == FigureColor.white ? 1 : -1,
    super(type: FigureType.pawn, color: color);

  Map<CellCoordinate, FigureAction> _getMoveCells(CellCoordinate current, Map<CellCoordinate, Figure> figuresPlacement) {
    final result = new Map<CellCoordinate, FigureAction>();

    final move = current.addY(yModificator);
    if (move != current && !figuresPlacement.containsKey(move)) {
      if (move.y == 8 && color == FigureColor.white) result[move] = FigureAction.transform;
      else if (move.y == 1 && color == FigureColor.black) result[move] = FigureAction.transform;
      else result[move] = FigureAction.move;
      if (
        (current.y == 2 && color == FigureColor.white)
        || (current.y == 7 && color == FigureColor.black)
      ) {
        final newPosition = current.addY(yModificator * 2);
        if (!figuresPlacement.containsKey(newPosition)) result[newPosition] = FigureAction.move;
      }
    }

    return result;
  }

  Map<CellCoordinate, FigureAction> _getAttackCells(CellCoordinate current, Map<CellCoordinate, Figure> figuresPlacement) {
    final result = new Map<CellCoordinate, FigureAction>();

    // Мы сейчас не учитываем взятие на проходе

    final attackLeft = current.add(CellCoordinate(x: -1, y: yModificator));
    if (
      attackLeft != current
      && figuresPlacement[attackLeft] != null
      && figuresPlacement[attackLeft].color != color
    ) result[attackLeft] = FigureAction.attack;

    final attackRight = current.add(CellCoordinate(x: 1, y: yModificator));
    if (
      attackRight != current
      && figuresPlacement[attackRight] != null
      && figuresPlacement[attackRight].color != color
    ) result[attackRight] = FigureAction.attack;

    return result;
  }

  Map<CellCoordinate, FigureAction> getPossibleCells(CellCoordinate current, Map<CellCoordinate, Figure> figuresPlacement) {
    return {
      ..._getMoveCells(current, figuresPlacement),
      ..._getAttackCells(current, figuresPlacement),
    };
  }
}

class Rook extends Figure {
  Rook({FigureColor color}): super(type: FigureType.rook, color: color);

  Map<CellCoordinate, FigureAction> _moveTo(
    CellCoordinate position,
    Map<CellCoordinate, Figure> figuresPlacement,
    CellCoordinate Function(CellCoordinate) changer,
  ) {
    final result = new Map<CellCoordinate, FigureAction>();

    while (true) {
      final newPosition = changer(position);
      if (newPosition == position) break;
      if (figuresPlacement[newPosition] != null) {
        if (figuresPlacement[newPosition].color != color) {
          result[newPosition] = FigureAction.attack;
        }
        break;
      }
      result[newPosition] = FigureAction.move;
      position = newPosition;
    }

    return result;
  }

  Map<CellCoordinate, FigureAction> getPossibleCells(CellCoordinate current, Map<CellCoordinate, Figure> figuresPlacement) {
    return {
      ..._moveTo(current, figuresPlacement, (coordinate) => coordinate.addX(-1)), // Left
      ..._moveTo(current, figuresPlacement, (coordinate) => coordinate.addX(1)), // Right
      ..._moveTo(current, figuresPlacement, (coordinate) => coordinate.addY(1)), // Up
      ..._moveTo(current, figuresPlacement, (coordinate) => coordinate.addY(-1)), // Down
    };
  }
}

class Knight extends Figure {
  final List<CellCoordinate> coordinateModifiers = [
    CellCoordinate(x: -2, y: 1),
    CellCoordinate(x: -2, y: -1),
    CellCoordinate(x: -1, y: 2),
    CellCoordinate(x: -1, y: -2),
    CellCoordinate(x: 1, y: 2),
    CellCoordinate(x: 1, y: -2),
    CellCoordinate(x: 2, y: 1),
    CellCoordinate(x: 2, y: -1),
  ];

  Knight({FigureColor color}): super(type: FigureType.knight, color: color);

  Map<CellCoordinate, FigureAction> getPossibleCells(CellCoordinate current, Map<CellCoordinate, Figure> figuresPlacement) {
    final result = new Map<CellCoordinate, FigureAction>();

    for (var modifier in coordinateModifiers) {
      final newPosition = current.add(modifier);
      if (newPosition != current) {
        if (figuresPlacement[newPosition] == null) result[newPosition] = FigureAction.move;
        else if (figuresPlacement[newPosition].color != color) {
          result[newPosition] = FigureAction.attack;
        }
      }
    }

    return result;
  }
}

class Bishop extends Figure {
  Bishop({FigureColor color}): super(type: FigureType.bishop, color: color);

  Map<CellCoordinate, FigureAction> _moveTo(
    CellCoordinate position,
    Map<CellCoordinate, Figure> figuresPlacement,
    CellCoordinate Function(CellCoordinate) changer,
  ) {
    final result = new Map<CellCoordinate, FigureAction>();

    while (true) {
      final newPosition = changer(position);
      if (newPosition == position) break;
      if (figuresPlacement[newPosition] != null) {
        if (figuresPlacement[newPosition].color != color) {
          result[newPosition] = FigureAction.attack;
        }
        break;
      }
      result[newPosition] = FigureAction.move;
      position = newPosition;
    }

    return result;
  }

  Map<CellCoordinate, FigureAction> getPossibleCells(CellCoordinate current, Map<CellCoordinate, Figure> figuresPlacement) {
    final leftUp = CellCoordinate(x: -1, y: 1);
    final leftDown = CellCoordinate(x: -1, y: -1);
    final rightUp = CellCoordinate(x: 1, y: 1);
    final rightDown = CellCoordinate(x: 1, y: -1);
    return {
      ..._moveTo(current, figuresPlacement, (coordinate) => coordinate.add(leftUp)),
      ..._moveTo(current, figuresPlacement, (coordinate) => coordinate.add(leftDown)),
      ..._moveTo(current, figuresPlacement, (coordinate) => coordinate.add(rightUp)),
      ..._moveTo(current, figuresPlacement, (coordinate) => coordinate.add(rightDown)),
    };
  }
}

class Queen extends Figure {
  Queen({FigureColor color}): super(type: FigureType.queen, color: color);

  Map<CellCoordinate, FigureAction> _moveTo(
    CellCoordinate position,
    Map<CellCoordinate, Figure> figuresPlacement,
    CellCoordinate Function(CellCoordinate) changer,
  ) {
    final result = new Map<CellCoordinate, FigureAction>();

    while (true) {
      final newPosition = changer(position);
      if (newPosition == position) break;
      if (figuresPlacement[newPosition] != null) {
        if (figuresPlacement[newPosition].color != color) {
          result[newPosition] = FigureAction.attack;
        }
        break;
      }
      result[newPosition] = FigureAction.move;
      position = newPosition;
    }

    return result;
  }

  Map<CellCoordinate, FigureAction> getPossibleCells(CellCoordinate current, Map<CellCoordinate, Figure> figuresPlacement) {
    final leftUp = CellCoordinate(x: -1, y: 1);
    final leftDown = CellCoordinate(x: -1, y: -1);
    final rightUp = CellCoordinate(x: 1, y: 1);
    final rightDown = CellCoordinate(x: 1, y: -1);
    return {
      ..._moveTo(current, figuresPlacement, (coordinate) => coordinate.add(leftUp)),
      ..._moveTo(current, figuresPlacement, (coordinate) => coordinate.add(leftDown)),
      ..._moveTo(current, figuresPlacement, (coordinate) => coordinate.add(rightUp)),
      ..._moveTo(current, figuresPlacement, (coordinate) => coordinate.add(rightDown)),
      ..._moveTo(current, figuresPlacement, (coordinate) => coordinate.addX(-1)), // Left
      ..._moveTo(current, figuresPlacement, (coordinate) => coordinate.addX(1)), // Right
      ..._moveTo(current, figuresPlacement, (coordinate) => coordinate.addY(1)), // Up
      ..._moveTo(current, figuresPlacement, (coordinate) => coordinate.addY(-1)), // Down
    };
  }
}

class King extends Figure {
  King({FigureColor color}): super(type: FigureType.king, color: color);

  Map<CellCoordinate, FigureAction> _moveTo(
    CellCoordinate position,
    Map<CellCoordinate, Figure> figuresPlacement,
    CellCoordinate Function(CellCoordinate) changer,
  ) {
    final result = new Map<CellCoordinate, FigureAction>();

    final newPosition = changer(position);
    if (newPosition == position) return result;
    if (figuresPlacement[newPosition] != null) {
      if (figuresPlacement[newPosition].color != color) {
        result[newPosition] = FigureAction.attack;
      }
      return result;
    }
    result[newPosition] = FigureAction.move;

    return result;
  }

  Map<CellCoordinate, FigureAction> getPossibleCells(CellCoordinate current, Map<CellCoordinate, Figure> figuresPlacement) {
    final leftUp = CellCoordinate(x: -1, y: 1);
    final leftDown = CellCoordinate(x: -1, y: -1);
    final rightUp = CellCoordinate(x: 1, y: 1);
    final rightDown = CellCoordinate(x: 1, y: -1);
    return {
      ..._moveTo(current, figuresPlacement, (coordinate) => coordinate.add(leftUp)),
      ..._moveTo(current, figuresPlacement, (coordinate) => coordinate.add(leftDown)),
      ..._moveTo(current, figuresPlacement, (coordinate) => coordinate.add(rightUp)),
      ..._moveTo(current, figuresPlacement, (coordinate) => coordinate.add(rightDown)),
      ..._moveTo(current, figuresPlacement, (coordinate) => coordinate.addX(-1)), // Left
      ..._moveTo(current, figuresPlacement, (coordinate) => coordinate.addX(1)), // Right
      ..._moveTo(current, figuresPlacement, (coordinate) => coordinate.addY(1)), // Up
      ..._moveTo(current, figuresPlacement, (coordinate) => coordinate.addY(-1)), // Down
    };
  }
}
