import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class StatisticsPage extends StatelessWidget {
  final Map<DateTime, String> moodEvents;

  StatisticsPage({required this.moodEvents});

  @override
  Widget build(BuildContext context) {
    Map<String, int> moodCounts = {
      '😀': 0,
      '🙂': 0,
      '😐': 0,
      '🙁': 0,
      '😢': 0,
    };

    moodEvents.values.forEach((mood) {
      moodCounts[mood] = (moodCounts[mood] ?? 0) + 1;
    });

    List<BarChartGroupData> barGroups = moodCounts.entries.map((entry) {
      return BarChartGroupData(
        x: entry.key.codeUnitAt(0),
        barRods: [
          BarChartRodData(y: entry.value.toDouble(), colors: [Colors.blue])
        ],
      );
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Mood Statistics'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            barGroups: barGroups,
            titlesData: FlTitlesData(
              leftTitles: SideTitles(showTitles: true),
              bottomTitles: SideTitles(
                showTitles: true,
                getTitles: (double value) {
                  return String.fromCharCode(value.toInt());
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
