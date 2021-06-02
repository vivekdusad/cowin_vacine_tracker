import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class GridItem extends StatelessWidget {
  final String heading;
  final String count;
  final Color color;
  final Color textColor;
  const GridItem({
    Key key,
    @required this.heading,
    @required this.textColor,
    @required this.count,
    @required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        width: 200,
        height: 100,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(heading,
                style: GoogleFonts.epilogue(
                    fontSize: 25,
                    color: textColor,
                    fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  count,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 27,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}