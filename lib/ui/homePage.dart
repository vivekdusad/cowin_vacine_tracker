import 'package:cowin_vaccine_tracker/main.dart';
import 'package:cowin_vaccine_tracker/models/pincode.dart';
import 'package:cowin_vaccine_tracker/state_managers/bloc/pincode_bloc.dart';
import 'package:cowin_vaccine_tracker/web/server.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);
  DateTime selectedDate;
  TextEditingController _pinCodeController = TextEditingController();
  GlobalKey _fomrKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      watch(serverprovider).getSessionByDistrict("303503", "1234556");
      return BlocProvider(
          create: (context) => PincodeBloc(server: ServerBase()),
          child: Scaffold(
              appBar: AppBar(
                title: Text("Vaccine Finder"),
              ),
              body: _content(context)));
    });
  }

  _content(BuildContext context) {
    return BlocBuilder<PincodeBloc, PincodeState>(
      builder: (context, state) {
        if (state is PincodeInitial) {
          return Form(
            key: _fomrKey,
            child: Column(
              children: [
                _pincodeFeild(),
                _datePicker(context),
                MaterialButton(
                  onPressed: () {
                    if (_pinCodeController.text.isNotEmpty) {
                      BlocProvider.of<PincodeBloc>(context).add(
                          PincodeRequested(pincode: _pinCodeController.text));
                    }

                    print(selectedDate.toString().split(' ')[0]);
                  },
                  child: Text("Get"),
                ),
              ],
            ),
          );
        } else if (state is PinCodeLoaded) {
          return Center(
            child: Text("hello"),
          );
        } else if (state is PinCodeFailed) {
          return Center(
            child: Text(state.e),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  _datePicker(BuildContext context) {
    return IconButton(
        icon: FaIcon(FontAwesomeIcons.calendar),
        onPressed: () async {
          selectedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2021, 3),
              lastDate: DateTime(2101));
        });
  }

  _pincodeFeild() {
    return BlocBuilder<PincodeBloc, PincodeState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: TextFormField(
            controller: _pinCodeController,
            decoration: InputDecoration(hintText: "PinCode"),
          ),
        );
      },
    );
  }
}
