part of 'state_bloc.dart';

abstract class StateState extends Equatable {
  const StateState();

  @override
  List<Object> get props => [];
}

class StateInitial extends StateState {}

class CoronaDataByStateLoaded extends StateState {
  final StateCorona corona;
  CoronaDataByStateLoaded({this.corona});
}

class CoronaDataStateLoading extends StateState {}

class CoronaDataErrorOccureed extends StateState {
  final Exception e;
  CoronaDataErrorOccureed({
    @required this.e,
  });
}
