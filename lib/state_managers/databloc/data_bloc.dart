import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cowin_vaccine_tracker/models/data.dart';
import 'package:cowin_vaccine_tracker/models/totaldata.dart';
import 'package:cowin_vaccine_tracker/web/server.dart';
import 'package:equatable/equatable.dart';

part 'data_event.dart';
part 'data_state.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  Server server;
  DataBloc({this.server}) : super(DataInitial());

  @override
  Stream<DataState> mapEventToState(
    DataEvent event,
  ) async* {
    if (event is CoronaDataRequested) {
      yield CoronaDataLoading();
      try {
        CoronaData coronaData = await server.getCoronaData();
        List<TotalDataInternal> graphData = await server.fetchTotalData();
        yield CoronaDataLoaded(coronaData,graphData);
      } on Exception catch (e) {
        yield CoronaDataErrorOccured(e);
      }
    }
  }
}
