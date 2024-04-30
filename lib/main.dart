import 'package:flutter/material.dart';
import 'package:app_test_01/mood_tracker_home_page.dart';

// 애플리케이션의 진입점입니다.
void main() => runApp(MoodTrackerApp());

// 애플리케이션의 최상위 위젯을 정의하는 클래스입니다.
// StatelessWidget을 상속받아, 상태가 없는 위젯임을 나타냅니다.
class MoodTrackerApp extends StatelessWidget {
  // flutter에서 모든 위젯은 선택적으로 'key'매개변수를 받을 수 있어야 한다.
  // 'Key? key'는 key가 null일 수도 있다는 null safety 기능
  // 'super(key : key)'는 StateleesWidget의 생성자에 key를 전달하여 부모 클래스 초기화
  MoodTrackerApp({Key? key}) : super(key : key);
  @override
  Widget build(BuildContext context) {
    // MaterialApp은 Material Design 앱을 생성하기 위한 루트 위젯입니다.
    return MaterialApp(
      title: 'Mood Tracker', // 앱의 타이틀을 정의합니다.
      theme: ThemeData(
        primarySwatch: Colors.blue, // 앱의 기본 색상 테마를 설정합니다.
      ),
      home: MoodTrackerHomePage(), // 앱이 시작될 때 표시될 홈페이지를 지정합니다.
    );
  }
}
