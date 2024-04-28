import 'package:flutter/material.dart';

void main() {
  runApp(MoodTrackerApp());
}

class MoodTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mood Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MoodTrackerHomePage(),
    );
  }
}

class MoodTrackerHomePage extends StatefulWidget {
  @override
  _MoodTrackerHomePageState createState() => _MoodTrackerHomePageState();
}

class _MoodTrackerHomePageState extends State<MoodTrackerHomePage> {
  // 기분 상태를 관리할 변수를 여기에 선언하세요.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mood Tracker'),
      ),
      body: Center(
        // 사용자가 기분을 입력하고 볼 수 있는 위젯을 여기에 구현하세요.
        child: Text("Mood Tracker UI goes here"),
      ),
      // 여기에 Floating Action Button이나 기타 버튼을 추가하여 기분을 입력할 수 있는 화면으로 이동할 수 있게 하세요.
    );
  }
}
