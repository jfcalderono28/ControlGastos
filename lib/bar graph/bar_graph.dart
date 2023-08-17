import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:control_gastos1/bar%20graph/bar_data.dart';

class MyBarGraph extends StatelessWidget {
  final List weeklySummary;
  const MyBarGraph({super.key, required this.weeklySummary});

  @override
  Widget build(BuildContext context) {
    BarData myBarData = BarData(
        monMounted: weeklySummary[0],
        tueMounted: weeklySummary[1],
        wedMounted: weeklySummary[2],
        thurMounted: weeklySummary[3],
        fryMounted: weeklySummary[4],
        satMounted: weeklySummary[5],
        sunMounted: weeklySummary[6]);

    myBarData.initializeBarData();

    return BarChart(BarChartData(
      maxY: 50000.0,
      minY: 0,
      barGroups: myBarData.barData
          .map((data) => BarChartGroupData(
              x: data.x, barRods: [BarChartRodData(toY: data.y)]))
          .toList(),
    ));
  }
}
