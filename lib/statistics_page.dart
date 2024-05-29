import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'mood.dart';

class StatisticsPage extends StatelessWidget {
  final Map<DateTime, String> moodEvents;
  Map<String, int> moodCounts = {};

  StatisticsPage({required this.moodEvents});

  @override
  Widget build(BuildContext context) {
    print("statistics_page의 context $context");
    _initMoodCounts(); // moood.dart 파일의 moodImages 변수에 설정된 path를 가져옴(종속성)
    _countMoodOccurrences();


    // Scaffold 위젯으로 페이지 레이아웃 설정
    return Scaffold(
      appBar: AppBar(
        title: Text('Mood Statistics'), // 앱 바의 제목 설정
      ),
      body: Padding(
        padding: const EdgeInsets.all(150), // 전체 패딩 설정
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround, // 막대 정렬 방식 설정
            barGroups: _createBarGroups(), // 생성된 barGroups 데이터 설정
            titlesData: FlTitlesData(
              show: true,
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (double value, TitleMeta meta){
                    return _getImageForTitle(value.toInt());
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _initMoodCounts(){
    for(var mood in moodImages.values){
      moodCounts[mood] = 0;
    }
  }

  void _countMoodOccurrences(){
    // moodEvents 맵을 순회하면서 각 감정의 빈도를 moodCounts 맵에 저장
    for(var mood in moodEvents.values) {
      // 감정의 빈도를 1 증가시킴, 기본값은 0
      moodCounts[mood] = (moodCounts[mood] ?? 0) + 1;
    }
  }

  List<BarChartGroupData> _createBarGroups(){
      List<BarChartGroupData> barGroups = [];
      int index = 0;

      // moodCounts 맵을 순회하면서 각 감정에 대한 BarChartGroupData 객체 생성 및 추가
      moodCounts.forEach((key, value) {
        barGroups.add(
          BarChartGroupData(
            x: index, // x축 값 설정
            barRods: [
              // 각 막대의 높이(y 값)와 색상 설정
              BarChartRodData(toY: value.toDouble(), color: Colors.blue),
            ],
          ),
        );
        index++; // 다음 감정에 대한 x축 값 증가
      });

      return barGroups;
  }

  Widget _getImageForTitle(int index){
    List<String> keys = moodCounts.keys.toList();

    if(index < 0 || index >= keys.length) {
      return const SizedBox.shrink(); // index가 유효하지 않을 때 아무것도 렌더링하지 않음
    }

    return Image.asset(keys[index]);
  }
}
