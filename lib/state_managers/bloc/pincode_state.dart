part of 'pincode_bloc.dart';

@immutable
abstract class PincodeState extends Equatable {
  @override
  List<Object> get props => [];
}

class PincodeInitial extends PincodeState {}

class PinCodeLoading extends PincodeState {}

class PinCodeLoaded extends PincodeState {
  // final PinCodeModel pinCodeModel;
  // PinCodeLoaded(this.pinCodeModel);
}

class PinCodeWrong extends PincodeState{}

class PinCodeFailed extends PincodeState {
  final e;
  PinCodeFailed(this.e);
}
