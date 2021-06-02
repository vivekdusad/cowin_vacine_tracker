import 'package:cowin_vaccine_tracker/models/data.dart';
import 'package:cowin_vaccine_tracker/ui/widgets/girdItem.dart';
import 'package:cowin_vaccine_tracker/ui/widgets/gridCountry.dart';
import 'package:cowin_vaccine_tracker/ui/widgets/gridStates.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Selection extends StatefulWidget {
  final CoronaData coronaData;
  const Selection({this.coronaData}) : super();

  @override
  _SelectionState createState() => _SelectionState();
}

class _SelectionState extends State<Selection> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            onTap: (value) {
              setState(() {});
            },
            tabs: [
              Tab(
                child: Text(
                  "India",
                  style: GoogleFonts.quicksand(
                      color: Colors.grey, fontWeight: FontWeight.bold),
                ),
              ),
              Tab(
                child: Text(
                  "State",
                  style: GoogleFonts.quicksand(
                      color: Colors.grey, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Container(
            height: 550,
            child: TabBarView(children: [
              GridIndia(
                coronaData: widget.coronaData,
              ),
              GridStates(),
            ]),
          )
        ],
      ),
    );
  }
}
