import 'package:flutter/material.dart';


class TotalCoronaCases extends StatelessWidget {
  final int coronaCases;
  const TotalCoronaCases({
    Key key,
    @required this.coronaCases,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 30),
            child: Column(
              children: [
                Text(coronaCases.toString(),
                    style: TextStyle(
                        fontSize: 55,
                        fontWeight: FontWeight.w800,
                        color: Colors.white)),
                Text('Total Cases',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
              ],
            ),
          )
        ],
      ),
    );
  }
}