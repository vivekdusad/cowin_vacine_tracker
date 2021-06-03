import 'package:cowin_vaccine_tracker/ui/widgets/temp2.dart';
import 'package:flutter/material.dart';

class Crousel extends StatelessWidget {
  const Crousel({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Carousel(),
      height: 200,
    );
  }
}