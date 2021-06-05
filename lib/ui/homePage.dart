import 'package:cowin_vaccine_tracker/main.dart';
import 'package:cowin_vaccine_tracker/state_managers/bloc/pincode_bloc.dart';
import 'package:cowin_vaccine_tracker/ui/widgets/errorWidget.dart';
import 'package:cowin_vaccine_tracker/ui/widgets/listcount.dart';
import 'package:cowin_vaccine_tracker/ui/widgets/temp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);
  DateTime selectedDate;
  TextEditingController _pinCodeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      watch(serverprovider).getStateCorona();
      return BlocProvider(
          create: (context) => PincodeBloc(server: watch(serverprovider)),
          child: Scaffold(
              resizeToAvoidBottomInset: false,
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
          key: _formKey,
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
                  getResultes(context);
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

  getResultes(BuildContext context) {
    FocusScope.of(context).unfocus(); //
    if (_formKey.currentState.validate()) {
      BlocProvider.of<PincodeBloc>(context)
          .add(SessionRequestedByPin(_pinCodeController.text, DateTime.now()));
      _formKey.currentState.save();
    }
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
                  child: LottieBuilder.asset("images/coviddis.json"),
                ),
              ],
            ),
          );
        } else if (state is SessionLoading) {
          return Center(
              child: Column(
            children: [
              LottieBuilder.asset("images/searching.json"),
              Text(
                "Searching...",
                style: GoogleFonts.ubuntu(fontSize: 20),
              ),
            ],
          ));
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
        } else {
          return ErrorMessage();
        }
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
            autofocus: true,
            keyboardType: TextInputType.number,
            validator: (String value) {
              if (value.length > 6 && value.length == 0) {
                return "Invalid";
              }
              return null;
            },
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
