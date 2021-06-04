import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.network("https://assets5.lottiefiles.com/packages/lf20_Z4BhGL.json"),
    );
  }
}
