import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'field.event.dart';
part 'field.state.dart';

class FieldBloc extends Bloc<FieldEvent, FieldState> {
  FieldBloc() : super(FieldInitial());

  @override
  Stream<FieldState> mapEventToState(
    FieldEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
