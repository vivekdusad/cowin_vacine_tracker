import 'package:cowin_vaccine_tracker/constants/constants.dart';
import 'package:cowin_vaccine_tracker/ui/maps.dart';
import 'package:cowin_vaccine_tracker/ui/widgets/ClipPathClass.dart';
import 'package:cowin_vaccine_tracker/ui/widgets/ClipPathClass2.dart';
import 'package:cowin_vaccine_tracker/ui/widgets/home_top.dart';
import 'package:cowin_vaccine_tracker/ui/widgets/intro_gradient.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cowin_vaccine_tracker/main.dart';
import 'package:cowin_vaccine_tracker/state_managers/databloc/data_bloc.dart';
import 'package:cowin_vaccine_tracker/ui/widgets/errorWidget.dart';
import 'package:cowin_vaccine_tracker/ui/widgets/loading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Intro extends StatefulWidget {
  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> with TickerProviderStateMixin {
  Animation<double> animation;
  Tween<double> float = Tween(begin: 0, end: 3);
  AnimationController controller;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    animation = controller.drive(float);
    controller.addListener(() {
      if (controller.value == 1.0)
        controller.reverse();
      else if (controller.value == 0.0) controller.forward();
    });
    controller.forward();
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
    //var f = NumberFormat.compact(locale: "en_US");
    return Consumer(builder: (context, watch, child) {
      DataBloc databloc = DataBloc(server: watch(serverprovider));
      databloc.add(CoronaDataRequested());
      return BlocProvider(
        create: (context) => databloc,
        child: Scaffold(
          backgroundColor: CustomColors.secondryBlue,
          body: BlocBuilder<DataBloc, DataState>(
            builder: (context, state) {
              if (state is CoronaDataLoading) {
                return LoadingScreen();
              } else if (state is CoronaDataErrorOccured) {
                return ErrorMessage();
              } else if (state is CoronaDataLoaded) {
                return Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      //mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 468,
                          color: Colors.white,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 15,
                              ),
                              HomeTopWidget(),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 20),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        topLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                        topRight: Radius.circular(10)),
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
                                              changeColor(
                                                  CustomColors.primaryBlue);
                                            },
                                            child: Center(
                                                child: Text('Today',
                                                    style: GoogleFonts.roboto(
                                                      color:
                                                          cardBackgroundColor ==
                                                                  Colors.white
                                                              ? CustomColors
                                                                  .primaryBlue
                                                              : Colors.white,
                                                    ))),
                                            style: NeumorphicStyle(
                                                depth: 0,
                                                color: cardBackgroundColor),
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
                                                        color:
                                                            cardBackgroundColor))),
                                            style: NeumorphicStyle(
                                              depth: 0,
                                              color: cardBackgroundColor ==
                                                      Colors.white
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
                                child: GraphSection(
                                  data: state.graphData,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '58%',
                                        style: TextStyle(
                                            color: Colors.pink, fontSize: 20),
                                      ),
                                      Text('INFECTION RISK',
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 12))
                                    ],
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        '24 June',
                                      ),
                                      Text('LIVE TRACKING',
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 12))
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          color: CustomColors.secondryBlue,
                          child: ClipPath(
                            clipper: ClipPathClass2(context,
                                MediaQuery.of(context).size.height - 528),
                            child: Container(
                              height: MediaQuery.of(context).size.height - 518,
                              color: CustomColors.primaryGrey,
                              child: SingleChildScrollView(
                                child: Table(
                                  border: TableBorder.all(
                                      color: Colors.black.withOpacity(0.6)),
                                  children: state.stateCorona
                                      .map((e) => TableRow(children: [
                                            Text(e.provinceState),
                                            Text(e.active.toString()),
                                            Text(e.deaths.toString()),
                                          ]))
                                      .toList(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: bottomBar(context, animation)),
                  ],
                );
              }
              return CircularProgressIndicator();
            },
          ),
          //bottomNavigationBar:
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

Widget bottomBar(context, Animation animation) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget child) {
          // print(animation.value);
          return Padding(
              padding: EdgeInsets.only(bottom: animation.value),
              child: rotatedSquare());
        },
      ),
      ClipPath(
        clipper: ClipPathClass(context),
        child: Container(
          color: CustomColors.primaryBlue,
          height: 40,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.circle,
                  color: Colors.white,
                  size: 7,
                ),
                SizedBox(
                  width: 4,
                ),
                Text('Live', style: GoogleFonts.roboto(color: Colors.white)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.circle,
                  color: Colors.white,
                  size: 7,
                ),
                SizedBox(
                  width: 4,
                ),
                Text('Cases', style: GoogleFonts.roboto(color: Colors.white)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.circle,
                  color: Colors.white,
                  size: 7,
                ),
                SizedBox(
                  width: 4,
                ),
                Text('Zones', style: GoogleFonts.roboto(color: Colors.white)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.circle,
                  color: Colors.white,
                  size: 7,
                ),
                SizedBox(
                  width: 4,
                ),
                Text('Help', style: GoogleFonts.roboto(color: Colors.white)),
              ],
            ),
          ]),
        ),
      ),
    ],
  );
}

Widget rotatedSquare() {
  return InkWell(
    onTap: () {
      Get.to(() => MapsPage());
    },
    child: RotationTransition(
      turns: new AlwaysStoppedAnimation(45 / 360),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        child: Container(
          height: 35.0,
          width: 35.0,
          decoration: BoxDecoration(
              gradient: new LinearGradient(colors: [
                CustomColors.primaryPink.withOpacity(0.7),
                Colors.pinkAccent.withOpacity(0.8)
              ], begin: Alignment.bottomLeft, end: Alignment.bottomRight),
              //color: CustomColors.primaryPink,
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
        ),
      ),
    ),
  );
}
