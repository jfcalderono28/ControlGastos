import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyBarGraph extends StatelessWidget {
  final List<double> data;
  const MyBarGraph({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    //myBarData.initializeBarData();

    return BarChart(BarChartData(
        maxY: 500000.0,
        minY: 0,
        barGroups: List.generate(data.length, (index) {
          final xValue = index;
          final yValue = data[index];
          return BarChartGroupData(
            barsSpace: 1,
            x: xValue,
            barRods: [BarChartRodData(toY: yValue)],
          );
        })));
  }
}
