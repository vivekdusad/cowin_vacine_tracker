import 'package:cowin_vaccine_tracker/state_managers/bloc/pincode_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotifyMe extends StatelessWidget {
  const NotifyMe({Key key}) : super(key: key);

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
                onPressed: () {},
                child: Text("Turn On Notifications"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
