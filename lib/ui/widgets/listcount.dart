import 'package:cowin_vaccine_tracker/models/pincode.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ListCoutn extends StatelessWidget {
  final Centers centers;

  const ListCoutn({Key key, this.centers}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final int _capacity = centers.sessions[0].availableCapacity;

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      padding: EdgeInsets.all(3),
                      color: Colors.amber,
                      child: Text(
                        centers.sessions[0].vaccine,
                        style: GoogleFonts.montserratAlternates(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )),
                  (_capacity != 0)
                      ? Capacity(
                          capacity: _capacity,
                        )
                      : Container(
                          padding: EdgeInsets.all(3),
                          color: Colors.red,
                          child: Text(
                            "Booked",
                            style: GoogleFonts.montserratAlternates(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SubPart(
                    text1: "Date",
                    text2: centers.sessions[0].date,
                    color: Colors.black,
                  ),
                  SubPart(
                    text1: "min Age",
                    text2: centers.sessions[0].minAgeLimit.toString() + "+",
                    color: Colors.black,
                  ),
                  SubPart(
                    text1: "Fee",
                    text2: centers.feeType,
                    color: Colors.blue,
                  ),
                ],
              ),
              if (_capacity > 0)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.purpleAccent,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: MaterialButton(
                        onPressed: () async {
                          await launch("https://www.cowin.gov.in/");
                        },
                        child: Text(
                          "Book Now",
                          style: GoogleFonts.quicksand(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
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
          text2,
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold, fontSize: 20, color: color),
        ),
      ],
    );
  }
}

class Capacity extends StatelessWidget {
  final int capacity;

  const Capacity({Key key, this.capacity}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(3),
        color: capacity < 3 ? Colors.yellow : Colors.green,
        child: Text(
          capacity.toString(),
          style: GoogleFonts.montserratAlternates(
              color: Colors.white, fontWeight: FontWeight.bold),
        ));
  }
}
