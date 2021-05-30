import 'package:cowin_vaccine_tracker/repos/pincodeRepo.dart';
import 'package:cowin_vaccine_tracker/ui/homePage.dart';
import 'package:cowin_vaccine_tracker/ui/introScreen.dart';
import 'package:cowin_vaccine_tracker/web/server.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
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
        primarySwatch: Colors.purple,
      ),
      home: Intro(),
    );
  }
}
