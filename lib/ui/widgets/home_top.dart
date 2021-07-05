import 'package:cowin_vaccine_tracker/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeTopWidget extends StatelessWidget {
  const HomeTopWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Current outbreak',
                    style: GoogleFonts.roboto(fontWeight: FontWeight.bold)),
                CircleAvatar(backgroundImage: AssetImage('images/in.png'))
              ],
            ),
          ),
          Row(
            children: [
              Icon(
                Icons.location_on,
                color: CustomColors.primaryGrey,
              ),
              SizedBox(
                width: 5,
              ),
              Text('India',
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold,
                      color: CustomColors.primaryBlue)),
            ],
          ),
        ],
      ),
    );
  }
}