import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        //ToDo make all lottie file as assets
        LottieBuilder.asset("images/noInternet.json"),
        Text("Some Error has Occured", style: GoogleFonts.ubuntu(fontSize: 20)),
      ],
    );
  }
}
