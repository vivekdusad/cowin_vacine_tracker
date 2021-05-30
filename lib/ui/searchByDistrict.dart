import 'package:cowin_vaccine_tracker/models/stateDistrict.dart';
import 'package:cowin_vaccine_tracker/state_managers/bloc/pincode_bloc.dart';
import 'package:cowin_vaccine_tracker/ui/widgets/listcount.dart';
import 'package:cowin_vaccine_tracker/ui/widgets/temp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../main.dart';

Districts _selectedDistrict;

class ByDistrictPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final PincodeBloc pincodeBloc = PincodeBloc(server: watch(serverprovider));
    pincodeBloc.add(StateListRequested());
    return BlocProvider(
      create: (context) => pincodeBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Search By District"),
        ),
        body: BlocBuilder<PincodeBloc, PincodeState>(
          builder: (context, state) {
            if (state is SessionLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is StateListLoaded) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  UpperContent(
                    states: state.states,
                  ),
                  _lowerContent(),
                ],
              );
            } else if (state is SessionResultByDistrict) {
              return Column(
                children: [
                  MyScreenDistrict(
                      dis_Code: _selectedDistrict.districtId.toString()),
                  Expanded(child: _lowerContent()),
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _lowerContent() {
    return BlocBuilder<PincodeBloc, PincodeState>(
      builder: (context, state) {
        print(state);
        if (state is SessionResultByDistrict) {
          return Scrollbar(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                //!bug here need to fix
                final DateFormat formatter = DateFormat('dd-MM-yyyy');
                final String formatted = formatter.format(DateTime.now());

                if (formatted
                        .compareTo(state.centers[index].sessions[0].date) ==
                    0) {
                  return ListCoutn(
                    centers: state.centers[index],
                  );
                }
                return null;
              },
              itemCount: state.centers.length,
            ),
          );
        } else if (state is SessionLoading) {
          return CircularProgressIndicator();
        } else {
          return Container();
        }
      },
    );
  }
}

class UpperContent extends StatefulWidget {
  final List<States> states;

  const UpperContent({Key key, this.states}) : super(key: key);
  @override
  _UpperContentState createState() => _UpperContentState();
}

class _UpperContentState extends State<UpperContent> {
  States _slectedValue;

  List<Districts> districts = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButton<States>(
          focusColor: Colors.white,
          value: _slectedValue,
          //elevation: 5,
          style: TextStyle(color: Colors.white),
          iconEnabledColor: Colors.black,
          items: widget.states.map<DropdownMenuItem<States>>((value) {
            return DropdownMenuItem<States>(
              value: value,
              child: Text(
                value.stateName,
                style: TextStyle(color: Colors.black),
              ),
            );
          }).toList(),
          hint: Text(
            "Please choose a State",
            style: TextStyle(
                color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
          ),
          onChanged: (States value) async {
            districts.clear();
            _selectedDistrict = null;
            districts = await ProviderContainer()
                .read(serverprovider)
                .getDistrict(value.stateId);
            // print("loaded");
            setState(() {
              _slectedValue = value;
            });
          },
        ),
        DropdownButton<Districts>(
          focusColor: Colors.white,
          value: _selectedDistrict,
          //elevation: 5,
          style: TextStyle(color: Colors.white),
          iconEnabledColor: Colors.black,
          items: districts.map<DropdownMenuItem<Districts>>((value) {
            return DropdownMenuItem<Districts>(
              value: value,
              child: Text(
                value.districtName,
                style: TextStyle(color: Colors.black),
              ),
            );
          }).toList(),
          hint: Text(
            "Please choose a District",
            style: TextStyle(
                color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
          ),
          onChanged: (Districts value) {
            setState(() {
              _selectedDistrict = value;
            });
          },
        ),
        MaterialButton(
          onPressed: () {
            BlocProvider.of<PincodeBloc>(context).add(
                SessionRequestedByDistrict(
                    _selectedDistrict.districtId.toString(), DateTime.now()));
          },
          child: Text("Get"),
        ),
      ],
    );
  }
}
