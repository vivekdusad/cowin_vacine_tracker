import 'package:cowin_vaccine_tracker/models/data.dart';
import 'package:cowin_vaccine_tracker/ui/widgets/girdItem.dart';
import 'package:flutter/material.dart';

class GridIndia extends StatelessWidget {
  const GridIndia({
    this.coronaData,
  });
  final CoronaData coronaData;

  @override
  Widget build(BuildContext context) {
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
            count: coronaData.recovered.toString(),
          ),
          GridItem(
            heading: "Active",
            color: Colors.blue[100],
            textColor: Colors.blue,
            count: coronaData.active.toString(),
          ),
          GridItem(
            heading: "Total",
            color: Colors.grey[100],
            textColor: Colors.grey,
            count: coronaData.cases.toString(),
          ),
          GridItem(
            heading: "Deaths",
            color: Colors.red[100],
            textColor: Colors.red,
            count: coronaData.deaths.toString(),
          ),
        ],
      ),
    );
  }
}
