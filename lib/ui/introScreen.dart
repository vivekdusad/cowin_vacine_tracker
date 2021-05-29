import 'package:cowin_vaccine_tracker/main.dart';
import 'package:cowin_vaccine_tracker/ui/homePage.dart';
import 'package:cowin_vaccine_tracker/ui/searchByDistrict.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class Intro extends ConsumerWidget {
  @override
  Widget build(BuildContext context,ScopedReader watch) {
    // watch(serverprovider).getStates()
    return Scaffold(
      appBar: AppBar(
                title: Text("Vaccine Finder"),
              ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MaterialButton(
              color: Colors.blue,
              onPressed: () {
                Get.to(() => HomePage());
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text("Search By PinCode",
                    style: TextStyle(
                      color: Colors.white,
                    )),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            MaterialButton(
              color: Colors.blue,
              onPressed: () {
                Get.to(() => ByDistrictPage());
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text("Search By District",
                    style: TextStyle(
                      color: Colors.white,
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
