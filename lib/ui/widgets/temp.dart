import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:cowin_vaccine_tracker/state_managers/bloc/pincode_bloc.dart';

class MyScreen extends StatefulWidget {
  String pinCode;
  MyScreen({
    Key key,
    @required this.pinCode,
  }) : super(key: key);
  @override
  _MyScreenState createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
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
