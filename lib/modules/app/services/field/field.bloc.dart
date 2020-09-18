import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

import 'package:chess/modules/app/models/main.dart';
import 'package:chess/utils/main.dart';

part 'field.event.dart';
part 'field.state.dart';

class FieldBloc extends Bloc<FieldEvent, FieldState> {
  FieldBloc() : super(FieldInitial());

  @override
  Stream<FieldState> mapEventToState(
    FieldEvent event,
  ) async* {
    if (event is FieldFigureMoveStart) yield _startMove(state, event);
    else if (event is FieldFigureMoveEnd) yield _endMove(state, event);
    else if (event is FieldCreateNewGame) yield _newGame(state, event);
  }

  FieldState _startMove(FieldState state, FieldFigureMoveStart event) {
    if (state.selectedIndex != null) return state;
    final _figure = state.figuresPlacement[event.position];
    if (_figure == null) return state;

    state.selectedIndex = event.position;
    state.movePossiblePositions = _figure.getPossibleCells(event.position, state.figuresPlacement);
    
    return state;
  }

  FieldState _endMove(FieldState state, FieldFigureMoveEnd event) {
    if (state.selectedIndex == null) return state;

    if (event.position == state.selectedIndex) return state;

    if (!state.movePossiblePositions.containsKey(event.position)) {
      state.selectedIndex = null;
      state.movePossiblePositions = new Map<CellCoordinate, FigureAction>();
      return state;
    }

    state.figuresPlacement[event.position] = state.figuresPlacement[state.selectedIndex];
    state.figuresPlacement.remove(state.selectedIndex);
    state.selectedIndex = null;
    state.movePossiblePositions = new Map<CellCoordinate, FigureAction>();
    return state;
  }

  FieldState _newGame(FieldState state, FieldCreateNewGame event) {
    state.figuresPlacement = defaultFigurePlacement;
    state.selectedIndex = null;
    state.movePossiblePositions = new Map<CellCoordinate, FigureAction>();

    return state;
  }
}
