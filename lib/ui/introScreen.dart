import 'package:cowin_vaccine_tracker/constants/constants.dart';
import 'package:cowin_vaccine_tracker/ui/statistics.dart';
import 'package:cowin_vaccine_tracker/ui/widgets/coronaColumn.dart';
import 'package:cowin_vaccine_tracker/ui/widgets/home_top.dart';
import 'package:cowin_vaccine_tracker/ui/widgets/intro_gradient.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:cowin_vaccine_tracker/main.dart';
import 'package:cowin_vaccine_tracker/state_managers/databloc/data_bloc.dart';
import 'package:cowin_vaccine_tracker/ui/homePage.dart';
import 'package:cowin_vaccine_tracker/ui/maps.dart';
import 'package:cowin_vaccine_tracker/ui/widgets/errorWidget.dart';
import 'package:cowin_vaccine_tracker/ui/widgets/loading.dart';
import 'package:cowin_vaccine_tracker/ui/widgets/piechartsample.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Intro extends StatefulWidget {
  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> with TickerProviderStateMixin {
  
  @override
  void initState() {
    super.initState();    
  }
  Color cardBackgroundColor = Colors.white;
  void changeColor(Color changeToColor) {
    setState(() {
      cardBackgroundColor = changeToColor;
    });
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);    
    var f = NumberFormat.compact(locale: "en_US");
    return Consumer(builder: (context, watch, child) {
      DataBloc databloc = DataBloc(server: watch(serverprovider));
      databloc.add(CoronaDataRequested());
      return BlocProvider(
        create: (context) => databloc,
        child: Scaffold(
          body: BlocBuilder<DataBloc, DataState>(
            builder: (context, state) {
              if (state is CoronaDataLoading) {
                return LoadingScreen();
              } else if (state is CoronaDataErrorOccured) {
                return ErrorMessage();
              } else if (state is CoronaDataLoaded) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      HomeTopWidget(),
                      Padding(
                        padding:EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        child: Card(
                          shape:RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(bottomLeft:
                            Radius.circular(10),
                                topLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)
                                ,topRight: Radius.circular(10)
                            ),
                          ),
                          elevation: 10,
                          color: Colors.white,

                          //padding:EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: NeumorphicButton(
                                    onPressed: () {
                                      changeColor(CustomColors.primaryBlue);
                                    },
                                    child: Center(
                                        child: Text('Today',
                                            style: GoogleFonts.roboto(
                                              color: cardBackgroundColor ==
                                                      Colors.white
                                                  ? CustomColors.primaryBlue
                                                  : Colors.white,
                                            ))),
                                    style: NeumorphicStyle(
                                      depth: 0,
                                      color: cardBackgroundColor
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: NeumorphicButton(
                                    onPressed: () {
                                      changeColor(Colors.white);
                                    },
                                    child: Center(
                                        child: Text('Tommorow',
                                            style: GoogleFonts.roboto(
                                                color: cardBackgroundColor))),
                                    style: NeumorphicStyle(
                                      depth: 0,
                                      color: cardBackgroundColor == Colors.white
                                          ? CustomColors.primaryBlue
                                          : Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GraphSection(data: state.graphData,),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('58%',style: TextStyle(color: Colors.pink,fontSize:20 ),),
                              Text('INFECTION RISK',style:TextStyle(color: Colors.grey,fontSize: 12))
                            ],
                          ),
                          SizedBox(width: 30,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('24 June',),
                              Text('LIVE TRACKING',style:TextStyle(color: Colors.grey,fontSize: 12))
                            ],
                          )
                        ],),
                      Divider(thickness: 2,),
                      // TabBar(
                      //   controller: TabController(length: 2, vsync: this),
                      //   tabs: [
                      //   Text('Statistics',style:TextStyle(color: CustomColors.primaryBlue,fontSize: 15,fontWeight: FontWeight.w700)),
                      //   Text('Schedules',style:TextStyle(color: CustomColors.primaryBlue,fontSize: 15,fontWeight: FontWeight.w700))
                      // ],),
                      // Divider(thickness: 2,)
                      // Container(
                      //   child: Column(children: [
                      //     Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           regularCard('images/vaccine.png',
                      //               'Search \n Vaccine by Pincode', () {
                      //             Get.to(HomePage());
                      //           }),
                      //         ]),
                      //     SizedBox(height: 20),
                      //     Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           regularCard('images/map.png', 'Map', () {
                      //             Get.to(() => MapsPage());
                      //           }),
                      //           regularCard('images/stats.png', 'Statistics',
                      //               () {
                      //             Get.to(StatisticsPage());
                      //           }),
                      //         ]),
                      //     SizedBox(
                      //       height: 30,
                      //     ),
                      //     PieChartSample1(
                      //       value: [
                      //         state.coronaData.recoveredPerOneMillion + 0.0,
                      //         state.coronaData.deathsPerOneMillion + 0.0,
                      //         state.coronaData.activePerOneMillion + 0.0,
                      //       ],
                      //     ),
                      //     Padding(
                      //       padding: const EdgeInsets.symmetric(
                      //           vertical: 10, horizontal: 8),
                      //       child: Card(
                      //         elevation: 3,
                      //         child: Padding(
                      //           padding: const EdgeInsets.all(30.0),
                      //           child: Row(
                      //             mainAxisAlignment:
                      //                 MainAxisAlignment.spaceAround,
                      //             children: [
                      //               CoronaColumn(
                      //                 colors: Colors.green,
                      //                 data:
                      //                     f.format(state.coronaData.recovered),
                      //                 string: "Recovered",
                      //               ),
                      //               CoronaColumn(
                      //                 colors: Colors.blue,
                      //                 data: f.format(state.coronaData.active),
                      //                 string: "Active",
                      //               ),
                      //               CoronaColumn(
                      //                 colors: Colors.red,
                      //                 data: f.format(state.coronaData.deaths),
                      //                 string: "Deaths",
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //       ),
                      //     )
                      //   ]),
                      // ),

                    ],
                  ),
                );
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      );
    });
  }
  
}
SizedBox regularCard(String iconName, String cardLabel, Function onTap) {
  return SizedBox(
    child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.grey[100],
          boxShadow: [
            BoxShadow(
                color: Colors.grey[300], offset: Offset.zero, blurRadius: 20)
          ],
        ),
        child: InkWell(
          onTap: onTap,
          child: Image.asset(
            iconName,
            width: 50,
            height: 50,
          ),
        ),
      ),
      SizedBox(height: 5),
      Text(cardLabel,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black))
    ]),
  );
}
