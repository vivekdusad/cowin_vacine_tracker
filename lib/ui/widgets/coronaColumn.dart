import 'package:flutter/material.dart';

class CoronaColumn extends StatelessWidget {
  final String data;
  final String string;
  final Color colors;
  const CoronaColumn({
    Key key,
    @required this.data,
    @required this.string,
    @required this.colors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          string,
          style: TextStyle(
            fontSize: 20,
            color: colors,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          data.toString(),
          style: TextStyle(
            fontSize: 22,
          ),
        ),
      ],
    );
  }
}
