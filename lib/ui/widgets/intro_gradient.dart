import 'package:cowin_vaccine_tracker/models/totaldata.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class GraphSection extends StatelessWidget {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];
  List<TotalDataInternal> data;
  GraphSection({Key key, this.data}) : super(key: key);
  var f = NumberFormat.compact(locale: "en_US");

  List<FlSpot> giveList() {
    List<FlSpot> list = [];
    for (int i = 0; i < data.length - 1; i++) {
      var a = data[i].value;
      var b = data[i + 1].value;
      print("a: $a  " + " b: $b");
      list.add(FlSpot(i.toDouble(), (b - a) + 0.0));
    }
    List<FlSpot> reversedList = new List.from(list.reversed);
    return reversedList;
  }

  String horizontalLines(double values) {
    if (values % 100 == 0) {
      return DateFormat('MMM').format(DateTime(0, DateTime(2020,01,30).add(Duration(days: values.toInt())).month));
    }
    return null;
  }

  String verticalLines(double values) {
    if (values % 100000 == 0) {
      return f.format(values);
    }
    return null;
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        drawHorizontalLine: false,
      ),
      borderData: FlBorderData(show: false),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: horizontalLines,
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: verticalLines,
          reservedSize: 28,
          margin: 12,
        ),
      ),
      lineBarsData: [
        LineChartBarData(
          spots: giveList(),
          isCurved: true,
          colors: gradientColors,
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: false,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 200,
        width: 400,
        child: LineChart(
          mainData(),
          swapAnimationDuration: Duration(milliseconds: 150), // Optional
          swapAnimationCurve: Curves.linear, // Optional
        ),
      ),
    );
  }
}
