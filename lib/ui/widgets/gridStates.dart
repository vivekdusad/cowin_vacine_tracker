import 'package:cowin_vaccine_tracker/constants/constants.dart';
import 'package:cowin_vaccine_tracker/main.dart';
import 'package:cowin_vaccine_tracker/models/stateCorna.dart';
import 'package:cowin_vaccine_tracker/state_managers/bloc/state_bloc.dart';

import 'package:cowin_vaccine_tracker/ui/widgets/girdItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GridStates extends StatefulWidget {
  @override
  _GridStatesState createState() => _GridStatesState();
}

class _GridStatesState extends State<GridStates> {
  String _chosenValue = "Rajasthan";
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      StateBloc databloc = StateBloc(server: watch(serverprovider));
      databloc.add(CoronaDataRequestedByState(coronaState: _chosenValue));
      return BlocProvider(
          create: (context) => databloc,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  StateDropDown(),
                ],
              ),
              BlocBuilder<StateBloc, StateState>(
                builder: (context, state) {
                  print(state);
                  if (state is CoronaDataByStateLoaded) {
                    return StatesContainers(
                      corona: state.corona,
                    );
                  }
                  return CircularProgressIndicator();
                },
              )
            ],
          ));
    });
  }
}

class StatesContainers extends StatelessWidget {
  const StatesContainers({
    this.corona,
  }) : super();
  final StateCorona corona;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        children: [
          GridItem(
            heading: "Deaths",
            color: Colors.red[100],
            textColor: Colors.red,
            count: corona.deaths.toString(),
          ),
          GridItem(
            heading: "Active",
            color: Colors.blue[100],
            textColor: Colors.blue,
            count: corona.active.toString(),
          ),
          GridItem(
            heading: "Recovered",
            color: Colors.green[100],
            textColor: Colors.green,
            count: corona.recovered.toString(),
          ),
          GridItem(
            heading: "Total",
            color: Colors.grey[100],
            textColor: Colors.grey,
            count: corona.confirmed.toString(),
          ),
        ],
      ),
    );
  }
}

class StateDropDown extends StatefulWidget {
  StateDropDown({Key key}) : super(key: key);

  @override
  _StateDropDownState createState() => _StateDropDownState();
}

class _StateDropDownState extends State<StateDropDown> {
  String _chosenValue = "Rajasthan";

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      focusColor: Colors.white,
      value: _chosenValue,
      //elevation: 5,
      style: TextStyle(color: Colors.white),
      iconEnabledColor: Colors.black,
      items: states.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: TextStyle(color: Colors.black),
          ),
        );
      }).toList(),
      hint: Text(
        _chosenValue,
        style: TextStyle(
            color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
      ),
      onChanged: (String value) {
        setState(() {
          _chosenValue = value;
        });
        BlocProvider.of<StateBloc>(context)
            .add(CoronaDataRequestedByState(coronaState: _chosenValue));
      },
    );
  }
}
