import 'package:cowin_vaccine_tracker/models/data.dart';
import 'package:cowin_vaccine_tracker/ui/widgets/girdItem.dart';
import 'package:flutter/material.dart';
import 'package:number_display/number_display.dart';

class GridIndia extends StatelessWidget {
  const GridIndia({
    this.coronaData,
  });
  final CoronaData coronaData;

  @override
  Widget build(BuildContext context) {
    final display = createDisplay();
    final display2 = createDisplay();
    return Container(
      height: 500,
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        children: [
          GridItem(
            heading: "Recovered",
            color: Colors.green[100],
            textColor: Colors.green,
            count: display2(coronaData.recovered),
          ),
          GridItem(
            heading: "Active",
            color: Colors.blue[100],
            textColor: Colors.blue,
            count: display(coronaData.active),
          ),
          GridItem(
            heading: "Total",
            color: Colors.grey[100],
            textColor: Colors.grey,
            count: display(coronaData.cases),
          ),
          GridItem(
            heading: "Deaths",
            color: Colors.red[100],
            textColor: Colors.red,
            count: display(coronaData.deaths),
          ),
        ],
      ),
    );
  }
}
