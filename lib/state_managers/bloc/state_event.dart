part of 'state_bloc.dart';

abstract class StateEvent extends Equatable {
  const StateEvent();

  @override
  List<Object> get props => [];
}
class CoronaDataRequestedByState extends StateEvent {
  final String coronaState;

  CoronaDataRequestedByState({this.coronaState});
  
}