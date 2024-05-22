import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class StatisticsPage extends StatelessWidget {
  final Map<DateTime, String> moodEvents;

  StatisticsPage({required this.moodEvents});

  @override
  Widget build(BuildContext context) {
    // 각 감정 이미지 경로를 키로, 해당 감정의 빈도를 값으로 갖는 맵 초기화
    Map<String, int> moodCounts = { // moodcounts: 감정 -> key, 횟수 : value
      'assets/Great.png': 0,
      'assets/Good.png': 0,
      'assets/Okay.png': 0,
      'assets/Bad.png': 0,
      'assets/Terrible.png': 0,
    };

    // moodEvents 맵을 순회하면서 각 감정의 빈도를 moodCounts 맵에 저장
    moodEvents.values.forEach((mood) {
      // 감정의 빈도를 1 증가시킴, 기본값은 0
      moodCounts[mood] = (moodCounts[mood] ?? 0) + 1;
    });

    // BarChart에 사용할 데이터 리스트 초기화
    List<BarChartGroupData> barGroups = [];
    int index = 0;

    // moodCounts 맵을 순회하면서 각 감정에 대한 BarChartGroupData 객체 생성 및 추가
    moodCounts.forEach((key, value) {
      barGroups.add(
        BarChartGroupData(
          x: index, // x축 값 설정
          barRods: [
            // 각 막대의 높이(y 값)와 색상 설정
            BarChartRodData(y: value.toDouble(), colors: [Colors.blue])
          ],
        ),
      );
      index++; // 다음 감정에 대한 x축 값 증가
    });

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
            barGroups: barGroups, // 생성된 barGroups 데이터 설정
            titlesData: FlTitlesData(
              leftTitles: SideTitles(showTitles: true), // y축 타이틀 표시 설정
              bottomTitles: SideTitles(
                showTitles: true, // x축 타이틀 표시 설정
                getTitles: (double value) {
                  // x축 타이틀을 문자열로 변환하여 반환
                  switch (value.toInt()) { // -> 실제 local 데이터와 매칭되지 않음
                    case 0:
                      return 'Great';
                    case 1:
                      return 'Good';
                    case 2:
                      return 'Okay';
                    case 3:
                      return 'Bad';
                    case 4:
                      return 'Terrible';
                    default:
                      return '';
                  }
                },
                reservedSize: 30, // x축 타이틀 영역 크기 설정
              ),
            ),
          ),
        ),
      ),
    );
  }
}
