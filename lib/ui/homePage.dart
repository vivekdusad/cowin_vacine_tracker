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
      watch(serverprovider).getDistrict(29);
      return BlocProvider(
          create: (context) => PincodeBloc(server: watch(serverprovider)),
          child: Scaffold(
              appBar: AppBar(
                title: Text("Search By Pincode"),
              ),
              body: Column(
                children: [
                  _upperContent(context),
                  _lowerContent(context),
                ],
              )));
    });
  }

  _upperContent(BuildContext context) {
    return BlocBuilder<PincodeBloc, PincodeState>(
      builder: (context, state) {
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
                        SessionRequestedByPin(
                            _pinCodeController.text, "vivek"));
                  }
                  print(selectedDate.toString().split(' ')[0]);
                },
                child: Text("Get"),
              ),
            ],
          ),
        );
      },
    );
  }

  _lowerContent(BuildContext context) {
    return BlocBuilder<PincodeBloc, PincodeState>(
      builder: (context, state) {
        if (state is PincodeInitial) {
          return Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Text("Search First")),
              ],
            ),
          );
        } else if (state is SessionLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is SessionResultByPinCode) {
          return ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Text(state.centers[index].name),
              );
            },
            itemCount: state.centers.length,
          );
        } else if (state is SessionErrorOccured) {
          return Center(child: Text(state.e.toString()));
        }
        return Container();
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
