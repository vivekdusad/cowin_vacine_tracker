import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cowin_vaccine_tracker/models/pincode.dart';
import 'package:cowin_vaccine_tracker/repos/pincodeRepo.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:cowin_vaccine_tracker/web/server.dart';
part 'pincode_event.dart';
part 'pincode_state.dart';

class PincodeBloc extends Bloc<PincodeEvent, PincodeState> {
  final Server server;
  PincodeBloc({this.server}) : super(PincodeInitial());

  @override
  Stream<PincodeState> mapEventToState(
    PincodeEvent event,
  ) async* {
    if (event is PincodeRequested) {
      print("1");
      yield PinCodeLoading();

      try {
        // final data = await server.getFindByPin(event.pincode);
        print("2");
        // yield PinCodeLoaded(data);
      } catch (e) {
        print(3);
        yield PinCodeFailed(e);
      }
    }
  }
}
