import 'package:cowin_vaccine_tracker/main.dart';
import 'package:cowin_vaccine_tracker/state_managers/bloc/pincode_bloc.dart';
import 'package:cowin_vaccine_tracker/ui/widgets/listcount.dart';
import 'package:cowin_vaccine_tracker/ui/widgets/temp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);
  DateTime selectedDate;
  TextEditingController _pinCodeController = TextEditingController();
  GlobalKey _fomrKey = GlobalKey<FormState>();
//   //yyyy-MM-dd
  //     final DateTime now = DateTime.now();

  // print(formatted);3240
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      watch(serverprovider).getCoronaData();
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
    double opacity = 0;
    return BlocBuilder<PincodeBloc, PincodeState>(
      builder: (context, state) {
        if (state is SessionResultByDistrict ||
            state is SessionResultByPinCode) {
          opacity = 1;
        }
        return Form(
          key: _fomrKey,
          child: Column(
            children: [
              _pincodeFeild(),
              // _datePicker(context),
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0)),
                hoverElevation: 16,
                splashColor: Colors.amber,
                color: Colors.blue,
                onPressed: () {
                  _getResultes(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Get",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Opacity(
                  opacity: opacity,
                  child: MyScreenPinCode(
                    pinCode: _pinCodeController.text,
                  )),
            ],
          ),
        );
      },
    );
  }

  _getResultes(BuildContext context) {
    if (_pinCodeController.text.isNotEmpty) {
      BlocProvider.of<PincodeBloc>(context)
          .add(SessionRequestedByPin(_pinCodeController.text, DateTime.now()));
    }
    print(selectedDate.toString().split(' ')[0]);
  }

  _lowerContent(BuildContext context) {
    return BlocBuilder<PincodeBloc, PincodeState>(
      builder: (context, state) {
        if (state is PincodeInitial) {
          return Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: Text(
                  "Search First",
                  style: TextStyle(fontSize: 24, color: Colors.red),
                )),
              ],
            ),
          );
        } else if (state is SessionLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is SessionResultByPinCode) {
          if (state.centers.length > 0) {
            return Expanded(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return ListCoutn(
                    centers: state.centers[index],
                  );
                },
                itemCount: state.centers.length,
              ),
            );
          } else {
            return Expanded(
              child: Center(
                child: Text("No Slots available"),
              ),
            );
          }
        } else if (state is SessionErrorOccured) {
          return Center(child: Text(state.e.toString()));
        }
        return Container(
          child: Text(state.toString()),
        );
      },
    );
  }

  _pincodeFeild() {
    return BlocBuilder<PincodeBloc, PincodeState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: TextFormField(
            textInputAction: TextInputAction.go,
            onFieldSubmitted: (String value) {
              _getResultes(context);
            },
            autofocus: true,
            focusNode: FocusNode(),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                labelText: "PinCode",
                hintText: "PinCode",
                border: OutlineInputBorder()),
            controller: _pinCodeController,
          ),
        );
      },
    );
  }
}
