import 'package:cowin_vaccine_tracker/main.dart';
import 'package:cowin_vaccine_tracker/state_managers/bloc/pincode_bloc.dart';
import 'package:cowin_vaccine_tracker/ui/widgets/errorWidget.dart';
import 'package:cowin_vaccine_tracker/ui/widgets/listcount.dart';
import 'package:cowin_vaccine_tracker/ui/widgets/temp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isEighteenSelected = false;

  bool isDose1Selected = false;

  bool isfortyFiveSelected = false;

  bool isDose2Selected = false;

  DateTime selectedDate;

  TextEditingController _pinCodeController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(10.0),
                    child: Text("Age Group",
                        style: GoogleFonts.lato(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      RadioChips(
                        isSelected: isEighteenSelected,
                        text: "18-44",
                        onTap: () {
                          setState(() {
                            isEighteenSelected = !isEighteenSelected;
                            isfortyFiveSelected = false;
                          });
                        },
                      ),
                      RadioChips(
                        isSelected: isfortyFiveSelected,
                        text: "45+",
                        onTap: () {
                          setState(() {
                            isEighteenSelected = false;
                            isfortyFiveSelected = !isfortyFiveSelected;
                          });
                        },
                      ),
                    ],
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text("Dose",
                        style: GoogleFonts.lato(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      RadioChips(
                        isSelected: isDose1Selected,
                        text: "Dose 1",
                        onTap: () {
                          setState(() {
                            isDose1Selected = !isDose1Selected;
                            isDose2Selected = false;
                          });
                        },
                      ),
                      RadioChips(
                        isSelected: isDose2Selected,
                        text: "Dose 2",
                        onTap: () {
                          setState(() {
                            isDose1Selected = false;
                            isDose2Selected = !isDose2Selected;
                          });
                        },
                      ),
                    ],
                  )
                ],
              ),
              Column(
                children: [
                  Text("Dose"),
                ],
              ),
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
              SizedBox(
                height: 10,
              ),
              MaterialButton(
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.blue),
                    borderRadius: new BorderRadius.circular(
                      10.0,
                    )),
                hoverElevation: 16,
                // splashColor: Colors.amber,
                color: Colors.white,
                onPressed: () {
                  // getResultes(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    "Notify me",
                    style: TextStyle(
                      color: Colors.blue,
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
                  child: LottieBuilder.asset(
                    "images/coviddis.json",
                    height: 50,
                    width: 50,
                  ),
                ),
              ],
            ),
          );
        } else if (state is SessionLoading) {
          return Center(
              child: Column(
            children: [
              LottieBuilder.asset(
                "images/searching.json",
                height: 50,
                width: 50,
              ),
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
        }
        return ErrorMessage();
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

class RadioChips extends StatefulWidget {
  bool isSelected;
  String text;
  Function onTap;
  RadioChips({
    this.isSelected,
    this.text,
    this.onTap,
    Key key,
  }) : super(key: key);

  @override
  _RadioChipsState createState() => _RadioChipsState();
}

class _RadioChipsState extends State<RadioChips> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(
            value: widget.isSelected,
            groupValue: widget.isSelected == true ? true : null,
            onChanged: (value) {
              setState(() {
                widget.isSelected = value;
                widget.onTap();
              });
            }),
        SizedBox(
          width: 1,
        ),
        Text(widget.text),
      ],
    );
  }
}
