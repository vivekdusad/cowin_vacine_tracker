import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'package:cowin_vaccine_tracker/main.dart';
import 'package:cowin_vaccine_tracker/state_managers/databloc/data_bloc.dart';
import 'package:cowin_vaccine_tracker/ui/homePage.dart';
import 'package:cowin_vaccine_tracker/ui/searchByDistrict.dart';

class Intro extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    // watch(serverprovider).getStates()
    DataBloc databloc = DataBloc(server: watch(serverprovider));
    databloc.add(CoronaDataRequested());
    return BlocProvider(
        create: (context) => databloc,
        child: Scaffold(
            appBar: AppBar(
              title: Text("Vaccine Finder"),
            ),
            body: BlocBuilder<DataBloc, DataState>(
              builder: (context, state) {
                if (state is CoronaDataLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is CoronaDataErrorOccured) {
                  return Center(
                    child: Text("Some Error Occured"),
                  );
                } else if (state is CoronaDataLoaded) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: LottieBuilder.network(
                          "https://assets8.lottiefiles.com/packages/lf20_p2evb1ab.json",
                          repeat: true,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.to(() => HomePage());
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              elevation: 15,
                              color: Colors.blue,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(" PinCode",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 24)),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(() => ByDistrictPage());
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              elevation: 15,
                              color: Colors.red[500],
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(" District",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 24)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        flex: 2,
                        child: GridView.count(
                          crossAxisCount: 2,
                          children: [
                            GridItem(
                              heading: "Deaths",
                              color: Colors.red[100],
                              textColor: Colors.red,
                              count: state.coronaData.deaths.toString(),
                            ),
                            GridItem(
                              heading: "Active",
                              color: Colors.blue[100],
                              textColor: Colors.blue,
                              count: state.coronaData.active.toString(),
                            ),
                            GridItem(
                              heading: "Recovered",
                              color: Colors.green[100],
                              textColor: Colors.green,
                              count: state.coronaData.recovered.toString(),
                            ),
                            GridItem(
                              heading: "Total",
                              color: Colors.grey[100],
                              textColor: Colors.grey,
                              count: state.coronaData.cases.toString(),
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                }
                return CircularProgressIndicator();
              },
            )));
  }
}

class GridItem extends StatelessWidget {
  final String heading;
  final String count;
  final Color color;
  final Color textColor;
  const GridItem({
    Key key,
    @required this.heading,
    @required this.textColor,
    @required this.count,
    @required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        width: 200,
        height: 100,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(heading,
                style: GoogleFonts.epilogue(
                    fontSize: 25,
                    color: textColor,
                    fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  count,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 30,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
