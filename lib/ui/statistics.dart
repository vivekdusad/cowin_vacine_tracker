import 'package:cowin_vaccine_tracker/main.dart';
import 'package:cowin_vaccine_tracker/state_managers/bloc/state_bloc.dart';
import 'package:cowin_vaccine_tracker/ui/introScreen.dart';
import 'package:cowin_vaccine_tracker/ui/widgets/gridStates.dart';
import 'package:cowin_vaccine_tracker/ui/widgets/piechartsample.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _chosenValue = "Rajasthan";
    var f = NumberFormat.compact(locale: "en_US");
    return Consumer(builder: (context, watch, child) {
      StateBloc databloc = StateBloc(server: watch(serverprovider));
      databloc.add(CoronaDataRequestedByState(coronaState: _chosenValue));
      return BlocProvider(
          create: (context) => databloc,
          child: Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    StateDropDown(),
                  ],
                ),
                BlocBuilder<StateBloc, StateState>(
                  builder: (context, state) {
                    print(state);
                    if (state is CoronaDataByStateLoaded) {
                      return SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              PieChartSample1(value: [
                                state.corona.recovered + 0.0,
                                state.corona.active + 0.0,
                                state.corona.deaths + 0.0
                              ]),
                              SizedBox(
                                height: 50,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 8),
                                child: Card(
                                  elevation: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.all(30.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        CoronaColumn(
                                          colors: Colors.green,
                                          data:
                                              f.format(state.corona.recovered),
                                          string: "Recovered",
                                        ),
                                        CoronaColumn(
                                          colors: Colors.blue,
                                          data: f.format(state.corona.active),
                                          string: "Active",
                                        ),
                                        CoronaColumn(
                                          colors: Colors.red,
                                          data: f.format(state.corona.deaths),
                                          string: "Deaths",
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    } else if (state is CoronaDataErrorOccureed) {
                      return Center(
                        child: Text(state.e.toString()),
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                )
              ],
            ),
          ));
    });
  }
}
