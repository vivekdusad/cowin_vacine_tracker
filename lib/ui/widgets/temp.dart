import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:cowin_vaccine_tracker/state_managers/bloc/pincode_bloc.dart';

// ignore: must_be_immutable
class MyScreenPinCode extends StatefulWidget {
  String pinCode;
  MyScreenPinCode({
    Key key,
    @required this.pinCode,
  }) : super(key: key);
  @override
  _MyScreenPinCodeState createState() => _MyScreenPinCodeState();
}

class _MyScreenPinCodeState extends State<MyScreenPinCode> {
  final _currentDate = DateTime.now();
  final _dayFormatter = DateFormat('d');
  final _monthFormatter = DateFormat('MMM');

  @override
  Widget build(BuildContext context) {
    final dates = <Widget>[];

    for (int i = 0; i < 5; i++) {
      final date = _currentDate.add(Duration(days: i));      
      dates.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: BlocBuilder<PincodeBloc, PincodeState>(
          builder: (context, state) {
            return MaterialButton(
              padding: EdgeInsets.symmetric(horizontal: 10),
              color: Colors.grey[350],
              child: Text(
                  _dayFormatter.format(date) + _monthFormatter.format(date)),
              onPressed: () {
                BlocProvider.of<PincodeBloc>(context)
                    .add(SessionRequestedByPin(widget.pinCode, date));
              },
            );
          },
        ),
      ));
    }

    return SingleChildScrollView(
      child: Row(
        children: dates.map((widget) => Expanded(child: widget)).toList(),
      ),
    );
  }
}

// ignore: must_be_immutable
class MyScreenDistrict extends StatefulWidget {
  String disCode;
  MyScreenDistrict({
    Key key,
    @required this.disCode,
  }) : super(key: key);
  @override
  _MyScreenDistrict createState() => _MyScreenDistrict();
}

class _MyScreenDistrict extends State<MyScreenDistrict> {
  final _currentDate = DateTime.now();
  final _dayFormatter = DateFormat('d');
  final _monthFormatter = DateFormat('MMM');

  @override
  Widget build(BuildContext context) {
    final dates = <Widget>[];

    for (int i = 0; i < 5; i++) {
      final date = _currentDate.add(Duration(days: i));
      dates.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: BlocBuilder<PincodeBloc, PincodeState>(
          builder: (context, state) {
            return MaterialButton(
              padding: EdgeInsets.symmetric(horizontal: 10),
              color: Colors.grey[350],
              child: Text(
                  _dayFormatter.format(date) + _monthFormatter.format(date)),
              onPressed: () {
                BlocProvider.of<PincodeBloc>(context)
                    .add(SessionRequestedByDistrict(widget.disCode, date));
              },
            );
          },
        ),
      ));
    }

    return SingleChildScrollView(
      child: Row(
        children: dates.map((widget) => Expanded(child: widget)).toList(),
      ),
    );
  }
}
