import 'dart:ui';

import 'package:flutter/cupertino.dart';

class ClipPathClass2 extends CustomClipper<Path> {
  var context;
  var height;
  ClipPathClass2(this.context,this.height);
  @override
  Path getClip(Size size) {
    var width=MediaQuery.of(context).size.width;
    var path = Path();
    path.moveTo(0, 0);
    path.lineTo(width,0);
    path.lineTo(width,height);
    path.lineTo(width/2+45,height);
    path.lineTo(width/2+15,height-30);
    path.quadraticBezierTo(width/2, height-48, width/2-15, height-30);
    path.lineTo(width/2-45, height);
    path.lineTo(0,height);
    path.lineTo(0, 0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}