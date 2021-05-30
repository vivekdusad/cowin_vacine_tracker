import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cowin_vaccine_tracker/models/data.dart';
import 'package:cowin_vaccine_tracker/web/server.dart';
import 'package:equatable/equatable.dart';

part 'data_event.dart';
part 'data_state.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  Server server;
  DataBloc() : super(DataInitial());

  @override
  Stream<DataState> mapEventToState(
    DataEvent event,
  ) async* {
    if (event is CoronaDataRequested) {
      yield CoronaDataLoading();
      try {
        CoronaData coronaData = await server.getCoronaData();
        yield CoronaDataLoaded(coronaData);
      } on Exception catch (e) {
        yield CoronaDataErrorOccured(e);
      }
    }
  }
}
