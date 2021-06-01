part of 'pincode_bloc.dart';

@immutable
abstract class PincodeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SessionRequestedByPin extends PincodeEvent {
  final String pinCode;
  final DateTime date;
  SessionRequestedByPin(this.pinCode, this.date);
}

class SessionRequestedByDistrict extends PincodeEvent {
  final String disCode;
  final DateTime date;
  SessionRequestedByDistrict(this.disCode, this.date);
}

class StateListRequested extends PincodeEvent {}

class DistrictListRequested extends PincodeEvent {
  final int stateId;
  DistrictListRequested(this.stateId);
}
