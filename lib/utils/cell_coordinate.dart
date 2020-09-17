import 'package:flutter/widgets.dart';

const LETTERS = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H'];

const min = 1;
const max = 8;

@immutable
class CellCoordinate {
  CellCoordinate({ this.x, this.y });

  static CellCoordinate fromString(String index) {
    final _x = index[0];
    final _y = index[1];

    return CellCoordinate(x: LETTERS.indexWhere((letter) => letter == _x) + 1, y: int.parse(_y));
  }

  final int x;
  final int y;

  @override
  String toString() {
    return '${LETTERS[x - 1]}$y';
  }

  @override
  int get hashCode => x.hashCode ^ y.hashCode;

  @override
  bool operator ==(Object other) => other is CellCoordinate && other.x == x && other.y == y;

  CellCoordinate addX(int value) {
    final newValue = x + value;
    if (min <= newValue && newValue <= max) return CellCoordinate(x: newValue, y: y);

    return this;
  }

  CellCoordinate addY(int value) {
    final newValue = y + value;
    if (min <= newValue && newValue <= max) return CellCoordinate(x: x, y: newValue);

    return this;
  }

  CellCoordinate add(CellCoordinate value) {
    final newValueX = x + value.x;
    if (newValueX < min || newValueX > max) return this;
    final newValueY = y + value.y;
    if (newValueY < min || newValueY > max) return this;

    return CellCoordinate(x: newValueX, y: newValueY);
  }
}