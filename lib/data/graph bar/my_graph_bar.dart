import 'package:expense_tracker_app/data/graph%20bar/graph_bar_data.dart';
import 'package:expense_tracker_app/res/components/getbottom_titles.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyGraphBar extends StatelessWidget {
  final double? maxY;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thurAmount;
  final double friAmount;
  final double satAmount;
  final double sunAmount;
  const MyGraphBar(
      {super.key,
      required this.maxY,
      required this.monAmount,
      required this.tueAmount,
      required this.wedAmount,
      required this.thurAmount,
      required this.friAmount,
      required this.satAmount,
      required this.sunAmount});

  @override
  Widget build(BuildContext context) {
    GraphBarData graphBarData = GraphBarData(
      monAmount: monAmount,
      tueAmount: tueAmount,
      wedAmount: wedAmount,
      thurAmount: thurAmount,
      friAmount: friAmount,
      satAmount: satAmount,
      sunAmount: sunAmount,
    );
    graphBarData.initializeGraphBarData();
    return BarChart(
      BarChartData(
        minY: 0,
        maxY: 1000,
        titlesData: FlTitlesData(
            show: true,
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                    showTitles: true, getTitlesWidget: getBottomTitles))),
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        barGroups: graphBarData.barData
            .map((data) => BarChartGroupData(
                  x: data.x,
                  barRods: [
                    BarChartRodData(
                      toY: data.y,
                      color: Colors.teal.shade500,
                      width: 25,
                      backDrawRodData: BackgroundBarChartRodData(
                        show: true,
                        toY: 1500,
                        color: Colors.grey[300],
                      ),
                    ),
                  ],
                ))
            .toList(),
      ),
    );
  }
}
