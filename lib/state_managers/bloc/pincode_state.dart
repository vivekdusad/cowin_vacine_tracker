part of 'pincode_bloc.dart';

@immutable
abstract class PincodeState extends Equatable {
  @override
  List<Object> get props => [];
}

class PincodeInitial extends PincodeState {}

class SessionLoading extends PincodeState {}

class SessionResultByPinCode extends PincodeState {
  final List<Centers> centers;
  SessionResultByPinCode(this.centers);
}

// ignore: must_be_immutable
class SessionResultByDistrict extends PincodeState {
  final List<Centers> centers;
  DateTime selectedTime;
  SessionResultByDistrict(this.centers,this.selectedTime);
}

class SessionErrorOccured extends PincodeState {
  final Exception e;
  SessionErrorOccured(this.e);
}

class StateListLoaded extends PincodeState {
  final List<States> states;
  StateListLoaded(this.states);
}

class DistrictListLoaded extends PincodeState {
  final List<Districts> districts;
  DistrictListLoaded(this.districts);
}
