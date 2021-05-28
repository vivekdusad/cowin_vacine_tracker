part of 'pincode_bloc.dart';

@immutable
abstract class PincodeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PincodeRequested extends PincodeEvent {
  final String pincode;
  PincodeRequested({this.pincode});
}
