import 'package:cowin_vaccine_tracker/main.dart';
import 'package:cowin_vaccine_tracker/ui/homePage.dart';
import 'package:cowin_vaccine_tracker/ui/searchByDistrict.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class Intro extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    // watch(serverprovider).getStates()
    return Scaffold(
      appBar: AppBar(
        title: Text("Vaccine Finder"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
                    padding: const EdgeInsets.all(40.0),
                    child: Text(" PinCode",
                        style: TextStyle(color: Colors.white, fontSize: 24)),
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
                    padding: const EdgeInsets.all(40.0),
                    child: Text(" District",
                        style: TextStyle(color: Colors.white, fontSize: 24)),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 15,
            color: Colors.red[500],
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Text(" District",
                  style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
          ),
        ],
      ),
    );
  }
}
