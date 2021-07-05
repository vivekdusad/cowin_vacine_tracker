import 'package:cowin_vaccine_tracker/main.dart';
import 'package:cowin_vaccine_tracker/state_managers/bloc/pincode_bloc.dart';
import 'package:cowin_vaccine_tracker/ui/pincodeResult.dart';
import 'package:cowin_vaccine_tracker/ui/widgets/radiochips.dart';
import 'package:cowin_vaccine_tracker/ui/widgets/temp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


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
              body: _upperContent(context)));
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
                    padding: const EdgeInsets.only(left: 20),
                    child: Text("Age Group",
                        style: GoogleFonts.lato(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    padding: const EdgeInsets.only(left: 20),
                    child: Text("Dose",
                        style: GoogleFonts.lato(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
      Get.to(() => PincodeResultsPage(
            pincode: _pinCodeController.text,
            isEighteenSelected: isEighteenSelected,
            isDose1Selected: isDose1Selected,
            isDose2Selected: isDose2Selected,
            isfourtyFiveSelected: isfortyFiveSelected,
          ));
    }
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
