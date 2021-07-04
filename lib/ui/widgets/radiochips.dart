import 'package:flutter/material.dart';



class RadioChips extends StatefulWidget {
  bool isSelected;
  String text;
  Function onTap;
  RadioChips({
    this.isSelected,
    this.text,
    this.onTap,
    Key key,
  }) : super(key: key);

  @override
  _RadioChipsState createState() => _RadioChipsState();
}

class _RadioChipsState extends State<RadioChips> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(
            value: widget.isSelected,
            groupValue: widget.isSelected == true ? true : null,
            onChanged: (value) {
              setState(() {
                widget.isSelected = value;
                widget.onTap();
              });
            }),
        SizedBox(
          width: 1,
        ),
        Text(widget.text),
      ],
    );
  }
}
