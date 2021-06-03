import 'package:cowin_vaccine_tracker/ui/widgets/TabsWidget.dart';
import 'package:cowin_vaccine_tracker/ui/widgets/buttons.dart';
import 'package:cowin_vaccine_tracker/ui/widgets/crousel.dart';
import 'package:cowin_vaccine_tracker/ui/widgets/searchText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cowin_vaccine_tracker/main.dart';
import 'package:cowin_vaccine_tracker/state_managers/databloc/data_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Intro extends StatefulWidget {
  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var androidInitalize = new AndroidInitializationSettings('splash');
    var iosInitalize = IOSInitializationSettings();
    var initalizationsSettings = new InitializationSettings(
        android: androidInitalize, iOS: iosInitalize);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initalizationsSettings,
        onSelectNotification: onNotificationSelected);
  }

  _showNotifications() async {
    var androidDetails = new AndroidNotificationDetails(
        "Channel ID", "Vaccine Finder", "Vaccine is available now");
    var iosDetails = new IOSNotificationDetails();
    var generalNotificationDetails =
        new NotificationDetails(android: androidDetails, iOS: iosDetails);
    await flutterLocalNotificationsPlugin.show(0, "Vaccine Available",
        "Vaccine is available now in your area", generalNotificationDetails);

    
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Consumer(builder: (context, watch, child) {
      DataBloc databloc = DataBloc(server: watch(serverprovider));
      databloc.add(CoronaDataRequested());
      return BlocProvider(
          create: (context) => databloc,
          child: Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: _showNotifications,
                child: Icon(Icons.notifications_active),
              ),
              appBar: AppBar(
                title: Text("Vaccine Finder"),
              ),
              body: BlocBuilder<DataBloc, DataState>(
                builder: (context, state) {
                  print(state);
                  if (state is CoronaDataLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is CoronaDataErrorOccured) {
                    return Center(
                      child: Text("Some Error Occured"),
                    );
                  } else if (state is CoronaDataLoaded) {
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          crousel(),
                          searchText(),
                          Buttons(),
                          Selection(
                            coronaData: state.coronaData,
                          ),
                        ],
                      ),
                    );
                  }
                  return CircularProgressIndicator();
                },
              )));
    });
  }

  Future onNotificationSelected(String payload) async {}
}
