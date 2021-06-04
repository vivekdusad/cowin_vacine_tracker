import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LottieBuilder.network("https://assets5.lottiefiles.com/packages/lf20_tasn1wnv.json"),
        Text(
          "Check Your Connection",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
