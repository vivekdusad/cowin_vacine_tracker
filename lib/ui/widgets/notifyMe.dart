import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class Notifyme extends StatelessWidget {
  Notifyme({Key key}) : super(key: key);
  TextEditingController _pinCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: TextField(
                  controller: _pinCodeController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Pincode',
                    hintText: 'Enter Your Pincode',
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              MaterialButton(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: Colors.amber,
                onPressed: () async {
                  if (_pinCodeController.text.isNotEmpty) {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setString('pincode', _pinCodeController.text);
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("You will be Notified")));
                    print(prefs.getString('pincode'));
                  }
                },
                child: Text("Turn On Notifications"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
