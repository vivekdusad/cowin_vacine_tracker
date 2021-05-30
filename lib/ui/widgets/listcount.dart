import 'package:cowin_vaccine_tracker/models/pincode.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListCoutn extends StatelessWidget {
  final Centers centers;

  const ListCoutn({Key key, this.centers}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // if you need this
          side: BorderSide(
            color: Colors.grey.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                centers.name,
                style: GoogleFonts.epilogue(fontSize: 24),
              ),
              SizedBox(
                height: 7,
              ),
              Container(
                  padding: EdgeInsets.all(3),
                  color: Colors.amber,
                  child: Text(
                    centers.sessions[0].vaccine,
                    style: GoogleFonts.montserratAlternates(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SubPart(
                    text1: "Date",
                    text2: "Nov25",
                    color: Colors.black,
                  ),
                  SubPart(
                    text1: "Time",
                    text2: "3:30-4:30",
                    color: Colors.black,
                  ),
                  SubPart(
                    text1: "Paid",
                    text2: "Free",
                    color: Colors.red,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SubPart extends StatelessWidget {
  final String text1;
  final String text2;
  final Color color;
  const SubPart({Key key, this.text1, this.text2, this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          text1,
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.grey),
        ),
        Text(
          "Nov25",
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold, fontSize: 20, color: color),
        ),
      ],
    );
  }
}
