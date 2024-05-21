import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class StatisticsPage extends StatelessWidget {
  final Map<DateTime, String> moodEvents;

  StatisticsPage({required this.moodEvents});

  @override
  Widget build(BuildContext context) {
    Map<String, int> moodCounts = {
      'assets/Great.png': 0,
      'assets/Good.png': 0,
      'assets/Okay.png': 0,
      'assets/Bad.png': 0,
      'assets/Terrible.png': 0,
    };

    moodEvents.values.forEach((mood) {
      print("mood를 봐바 $mood");
      /*
        mood를 봐바 assets/Good.png
        mood를 봐바 assets/Good.png
        mood를 봐바 assets/Good.png
        mood를 봐바 assets/Okay.png
        mood를 봐바 assets/Okay.png
        mood를 봐바 assets/Terrible.png
       */
      moodCounts[mood] = (moodCounts[mood] ?? 0) + 1;
    });

    List<BarChartGroupData> barGroups = [];
    int index = 0;
    moodCounts.forEach((key, value) {
      barGroups.add(
        BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(y: value.toDouble(), colors: [Colors.blue])
          ],
        ),
      );
      index++;
    });

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
