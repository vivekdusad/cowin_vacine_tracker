import 'dart:ui';

import 'package:flutter/cupertino.dart';

class ClipPathClass extends CustomClipper<Path> {
  var context;
  ClipPathClass(this.context);
  @override
  Path getClip(Size size) {
    var width=MediaQuery.of(context).size.width;
    var path = Path();
    path.moveTo(0, 0);
    path.lineTo(width/2-30,0);
    path.lineTo(width/2-14,14);
    //path.quadraticBezierTo(width/2, 30, width/2, 20);
    path.quadraticBezierTo(width/2, 30, width/2+14, 14);
    path.lineTo(width/2+30,0);
    path.lineTo(width, 0);
    path.lineTo(width, 42);
    path.lineTo(0, 42);
    path.lineTo(0, 0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}