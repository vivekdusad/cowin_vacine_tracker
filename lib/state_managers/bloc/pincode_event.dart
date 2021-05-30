part of 'pincode_bloc.dart';

@immutable
abstract class PincodeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SessionRequestedByPin extends PincodeEvent {
  final String pin_code;
  final DateTime date;
  SessionRequestedByPin(this.pin_code, this.date);
}

class SessionRequestedByDistrict extends PincodeEvent {
  final String dis_code;
  final String date;
  SessionRequestedByDistrict(this.dis_code, this.date);
}

class StateListRequested extends PincodeEvent {}

class DistrictListRequested extends PincodeEvent {
  final int state_id;
  DistrictListRequested(this.state_id);
}
