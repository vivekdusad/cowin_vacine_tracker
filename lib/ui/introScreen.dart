import 'package:cowin_vaccine_tracker/ui/statistics.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:cowin_vaccine_tracker/main.dart';
import 'package:cowin_vaccine_tracker/state_managers/databloc/data_bloc.dart';
import 'package:cowin_vaccine_tracker/ui/homePage.dart';
import 'package:cowin_vaccine_tracker/ui/maps.dart';
import 'package:cowin_vaccine_tracker/ui/searchByDistrict.dart';
import 'package:cowin_vaccine_tracker/ui/widgets/errorWidget.dart';
import 'package:cowin_vaccine_tracker/ui/widgets/loading.dart';
import 'package:cowin_vaccine_tracker/ui/widgets/piechartsample.dart';
import 'package:cowin_vaccine_tracker/ui/widgets/totalcoronacases.dart';
import 'package:intl/intl.dart';

class Intro extends StatefulWidget {
  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  @override
  void initState() {
    super.initState();
    var androidInitalize = new AndroidInitializationSettings('splash');
    var iosInitalize = IOSInitializationSettings();
    var initalizationsSettings = new InitializationSettings(
        android: androidInitalize, iOS: iosInitalize);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initalizationsSettings,
        onSelectNotification: onNotificationSelected);
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    
    var size = MediaQuery.of(context).size;
    var f = NumberFormat.compact(locale: "en_US");
    return Consumer(builder: (context, watch, child) {
      watch(serverprovider).fetchCases();
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
                return ListView(children: [
                  Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                "images/bg.png",
                              ),
                              fit: BoxFit.fill)),
                      child: Column(
                        children: [
                          TotalCoronaCases(
                            coronaCases: state.coronaData.active,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30)),
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 40),
                            child: Column(children: [
                              SizedBox(height: 40),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    regularCard('images/vaccine.png',
                                        'Search \n Vaccine by Pincode', () {
                                      Get.to(HomePage());
                                    }),
                                    regularCard('images/protection.png',
                                        'Search \n Vaccine by Pincode', () {
                                      Get.to(() => ByDistrictPage());
                                    }),
                                  ]),
                              SizedBox(height: 20),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    regularCard('images/map.png', 'Map', () {
                                      Get.to(() => MapsPage());
                                    }),
                                    regularCard(
                                        'images/stats.png', 'Statistics', () {
                                      Get.to(StatisticsPage());
                                    }),
                                  ]),
                              SizedBox(
                                height: 30,
                              ),
                              PieChartSample1(
                                value: [
                                  state.coronaData.recoveredPerOneMillion + 0.0,
                                  state.coronaData.deathsPerOneMillion + 0.0,
                                  state.coronaData.activePerOneMillion + 0.0,
                                ],
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
                                          data: f.format(
                                              state.coronaData.recovered),
                                          string: "Recovered",
                                        ),
                                        CoronaColumn(
                                          colors: Colors.blue,
                                          data:
                                              f.format(state.coronaData.active),
                                          string: "Active",
                                        ),
                                        CoronaColumn(
                                          colors: Colors.red,
                                          data:
                                              f.format(state.coronaData.deaths),
                                          string: "Deaths",
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ]),
                          )
                        ],
                      )),
                ]);
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      );
    });
  }

  Container mainCard(context) {
    return Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[100],
          boxShadow: [
            BoxShadow(
                color: Colors.grey[300], offset: Offset.zero, blurRadius: 20)
          ],
        ),
        child: Row(children: [
          Container(
            alignment: Alignment.center,
            width: (MediaQuery.of(context).size.width - 130) / 2,
            height: 100,
            child: Image.asset(
              "images/corona.png",
            ),
          ),
          SizedBox(
            width: (MediaQuery.of(context).size.width - 80) / 2,
            height: 100,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Corona Cases',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: Colors.black)),
                  SizedBox(height: 7),
                  Text('Search Corona by State',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: Colors.grey[600]))
                ]),
          ),
        ]));
  }

  // ignore: missing_return
  Future onNotificationSelected(String payload) {}
}

class CoronaColumn extends StatelessWidget {
  final String data;
  final String string;
  final Color colors;
  const CoronaColumn({
    Key key,
    @required this.data,
    @required this.string,
    @required this.colors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          string,
          style: TextStyle(
            fontSize: 20,
            color: colors,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          data.toString(),
          style: TextStyle(
            fontSize: 22,
          ),
        ),
      ],
    );
  }
}

class Pie extends StatelessWidget {
  var state;
  Pie({
    Key key,
    this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      child: PieChart(PieChartData(sections: [
        PieChartSectionData(
          value: state.coronaData.recovered + 0.0,
        ),
        PieChartSectionData(
          value: state.coronaData.active + 0.0,
        ),
        PieChartSectionData(
          value: state.coronaData.recovered + 0.0,
        )
      ])),
    );
  }
}

void showSnackbar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
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
