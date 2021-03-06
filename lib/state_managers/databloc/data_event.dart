part of 'data_bloc.dart';

abstract class DataEvent extends Equatable {
  const DataEvent();

  @override
  List<Object> get props => [];
}

class CoronaDataRequested extends DataEvent {}

class CoronaDataRequestedByState extends DataEvent {
  final String coronaState;

  CoronaDataRequestedByState({this.coronaState});
  
}


