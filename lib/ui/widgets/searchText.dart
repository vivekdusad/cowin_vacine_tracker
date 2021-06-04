import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


// ignore: camel_case_types
class searchText extends StatelessWidget {
  const searchText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text("Search Vaccine",
          style:
              GoogleFonts.quicksand(fontSize: 30, fontWeight: FontWeight.bold)),
    );
  }
}