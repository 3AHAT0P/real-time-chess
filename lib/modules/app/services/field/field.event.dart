part of 'field.bloc.dart';

@immutable
abstract class FieldEvent {}

class FieldFigureMoveStart extends FieldEvent {
  FieldFigureMoveStart({ @required this.position }): super();

  final CellCoordinate position;
}

class FieldFigureMoveEnd extends FieldEvent {
  FieldFigureMoveEnd({ @required this.position }): super();

  final CellCoordinate position;
}

class FieldCreateNewGame extends FieldEvent {
  FieldCreateNewGame(): super();
}