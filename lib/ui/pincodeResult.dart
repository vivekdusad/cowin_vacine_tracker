import 'package:cowin_vaccine_tracker/main.dart';
import 'package:cowin_vaccine_tracker/models/pincode.dart';
import 'package:cowin_vaccine_tracker/state_managers/bloc/pincode_bloc.dart';
import 'package:cowin_vaccine_tracker/ui/widgets/listcount.dart';
import 'package:cowin_vaccine_tracker/ui/widgets/temp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class PincodeResultsPage extends StatelessWidget {
  final String pincode;
  final bool isEighteenSelected;
  final bool isfourtyFiveSelected;
  final bool isDose1Selected;
  final bool isDose2Selected;
  const PincodeResultsPage(
      {Key key,
      this.pincode,
      this.isDose1Selected,
      this.isDose2Selected,
      this.isEighteenSelected,
      this.isfourtyFiveSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final pincodebloc = PincodeBloc(server: watch(serverprovider));
      pincodebloc.add(SessionRequestedByPin(pincode, DateTime.now()));

      return Scaffold(
        body: BlocProvider(
            create: (context) => pincodebloc,
            child: BlocBuilder<PincodeBloc, PincodeState>(
              builder: (context, state) {
                if (state is SessionLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is SessionResultByPinCode) {
                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Container(height: 50, child: _UpperRow()),
                        Container(
                            height: 50,
                            child: MyScreenPinCode(pinCode: pincode)),
                        state.centers.isNotEmpty
                            ? ListPart(
                                pincode: pincode,
                                centers: state.centers,
                                isDose1Selected: isDose1Selected,
                                isDose2Selected: isDose2Selected,
                                isEighteenSelected: isEighteenSelected,
                                isfourtyFiveSelected: isfourtyFiveSelected,
                              )
                            : Center(
                                child: Text("No Results Found !",
                                    style: GoogleFonts.ubuntu(fontSize: 18)))
                      ],
                    ),
                  );
                }
                return Container();
              },
            )),
      );
    });
  }
}

class _UpperRow extends StatelessWidget {
  const _UpperRow({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          icon: FaIcon(FontAwesomeIcons.arrowLeft),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}

class ListPart extends StatelessWidget {
  final String pincode;
  List<Centers> centers;
  final bool isEighteenSelected;
  final bool isfourtyFiveSelected;
  final bool isDose1Selected;
  final bool isDose2Selected;
  ListPart(
      {Key key,
      this.centers,
      this.pincode,
      this.isDose1Selected,
      this.isDose2Selected,
      this.isEighteenSelected,
      this.isfourtyFiveSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: centers.length,
          itemBuilder: (context, index) {
            if (isEighteenSelected &&
                centers[index].sessions[0].minAgeLimit < 45) {
              if (isDose1Selected &&
                  centers[index].sessions[0].availableCapacityDose1 > 0) {
                return ListCoutn(
                  centers: centers[index],
                );
              } else if (isDose2Selected &&
                  centers[index].sessions[0].availableCapacityDose2 > 0) {
                return ListCoutn(
                  centers: centers[index],
                );
              } else {
                return ListCoutn(
                  centers: centers[index],
                );
              }
            } else if (isfourtyFiveSelected &&
                centers[index].sessions[0].minAgeLimit == 45) {
              if (isDose1Selected &&
                  centers[index].sessions[0].availableCapacityDose1 > 0) {
                return ListCoutn(
                  centers: centers[index],
                );
              } else if (isDose2Selected &&
                  centers[index].sessions[0].availableCapacityDose2 > 0) {
                return ListCoutn(
                  centers: centers[index],
                );
              } else {
                return ListCoutn(
                  centers: centers[index],
                );
              }
            } else {
              return ListCoutn(
                centers: centers[index],
              );
            }
          }),
    );
  }
}
