import 'package:cowin_vaccine_tracker/ui/homePage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Intro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MaterialButton(
              color: Colors.blue,
              onPressed: () {
                Get.to(HomePage());
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
              onPressed: () {},
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
