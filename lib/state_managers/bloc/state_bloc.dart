import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cowin_vaccine_tracker/models/stateCorna.dart';
import 'package:cowin_vaccine_tracker/web/server.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
part 'state_event.dart';
part 'state_state.dart';

class StateBloc extends Bloc<StateEvent, StateState> {
  Server server;
  StateBloc({this.server}) : super(StateInitial());

  @override
  Stream<StateState> mapEventToState(
    StateEvent event,
  ) async* {
    if (event is CoronaDataRequestedByState) {
      yield CoronaDataStateLoading();
      try {
        List<StateCorona> corona = await server.getStateCorona();
        final filter = corona
            .where((element) => element.provinceState == event.coronaState)
            .toList();
        print(filter.first.provinceState);
        yield CoronaDataByStateLoaded(corona:filter.first);
      } on Exception catch (e) {
        yield CoronaDataErrorOccureed(e: e);
      }
    }
  }
}
