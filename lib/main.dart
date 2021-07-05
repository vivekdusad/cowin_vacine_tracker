import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cowin_vaccine_tracker/repos/pincodeRepo.dart';
import 'package:cowin_vaccine_tracker/ui/introScreen.dart';
import 'package:cowin_vaccine_tracker/ui/widgets/internetConnection.dart';
import 'package:cowin_vaccine_tracker/web/server.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

const myTask = "syncWithTheBackEnd";

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    // initialise the plugin of flutterlocalnotifications.
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('pincode')) {
      String pincode = prefs.getString('pincode');
      var list = await ProviderContainer()
          .read(serverprovider)
          .getSessionByPincode(pincode, DateTime.now());
      var filter = list
          .where((element) => element.sessions[0].availableCapacity > 0)
          .toList();
      if (filter.isNotEmpty) {
        FlutterLocalNotificationsPlugin flip =
            new FlutterLocalNotificationsPlugin();
        var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
        // ignore: non_constant_identifier_names
        var Ios = new IOSInitializationSettings();
        var settings = new InitializationSettings(android: android, iOS: Ios);
        flip.initialize(settings);
        _showNotificationWithDefaultSound(
            flip, filter.first.sessions[0].availableCapacity.toString());
      }
    }
    return Future.value(true);
  });
}

Future _showNotificationWithDefaultSound(flip, String centerName) async {
  // Show a notification after every 15 minute with the first
  // appearance happening a minute after invoking the method
  var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
    'your channel id',
    'your channel name',
    'your channel description',
  );
  var iOSPlatformChannelSpecifics = new IOSNotificationDetails();

  // initialise channel platform for both Android and iOS device.
  var platformChannelSpecifics = new NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics);
  await flip.show(0, 'Vaccine Found', 'Vaccine Count: $centerName',
      platformChannelSpecifics,
      payload: 'Default_Sound');
}

void main() {

  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(callbackDispatcher);
  Workmanager().registerPeriodicTask(
    "2",
    myTask,
    frequency: Duration(hours: 1), // change duration according to your needs
  );
  runApp(ProviderScope(child: MyApp()));
}

final pincodeRepo = Provider<PinCodeRepo>((ref) {
  return PinCodeRepo(ServerBase());
});
final serverprovider = Provider<ServerBase>((ref) {
  return ServerBase();
});

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.blue,
      ),
      home: Intro(),
    );
  }

  checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return Intro();
    } else if (connectivityResult == ConnectivityResult.none) {
      return NoInternet();
    }
  }
}
