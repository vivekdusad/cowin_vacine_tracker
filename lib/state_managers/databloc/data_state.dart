part of 'data_bloc.dart';

abstract class DataState extends Equatable {
  const DataState();

  @override
  List<Object> get props => [];
}

class DataInitial extends DataState {}
class CoronaDataLoaded extends DataState {
  final CoronaData coronaData;

  CoronaDataLoaded(this.coronaData);
}
class CoronaDataLoading extends DataState {}
class CoronaDataErrorOccured extends DataState {
  final Exception e;
  CoronaDataErrorOccured(this.e);
}



