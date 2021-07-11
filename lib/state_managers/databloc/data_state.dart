part of 'data_bloc.dart';

abstract class DataState extends Equatable {
  const DataState();

  @override
  List<Object> get props => [];
}

class DataInitial extends DataState {}

class CoronaDataLoaded extends DataState {
  final CoronaData coronaData;
  final List<TotalDataInternal> graphData;
  List<Rows> todayCases;
  final List<StateCorona> stateCorona;
  CoronaDataLoaded(this.coronaData, this.graphData, this.stateCorona,this.todayCases);
}

class CoronaDataLoading extends DataState {}

class CoronaDataErrorOccured extends DataState {
  final Exception e;
  CoronaDataErrorOccured(this.e);
}
