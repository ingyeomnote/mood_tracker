import 'package:flutter/material.dart';
import 'package:app_test_01/mood_manager.dart';
import 'package:app_test_01/mood_dialog.dart';
import 'package:app_test_01/mood_calendar.dart';

// 상태 관리가 필요한 홈 페이지 위젯을 정의합니다.
class MoodTrackerHomePage extends StatefulWidget {
  @override
  _MoodTrackerHomePageState createState() => _MoodTrackerHomePageState();
}

// MoodTrackerHomePage 위젯의 상태를 관리하는 클래스입니다.
class _MoodTrackerHomePageState extends State<MoodTrackerHomePage> {
  String _mood = 'Good'; // 현재 사용자의 기분을 저장하는 변수입니다.
  String _memo = ''; // 사용자가 입력한 메모를 저장하는 변수입니다.
  DateTime _selectedDay = DateTime.now(); // 선택된 날짜를 저장합니다.
  Map<DateTime, List<dynamic>> _moods = {}; // 날짜별 기분과 메모를 저장하는 맵입니다.
  TextEditingController _memoController = TextEditingController(); // 메모 입력을 위한 컨트롤러입니다.
  MoodManager moodManager = MoodManager(); // MoodManager 인스턴스를 생성합니다.

  @override
  void initState() {
    super.initState();
    _loadMoods(); // 초기화 시 기분 데이터를 불러옵니다.
  }

  // 기분 데이터를 불러오는 비동기 함수입니다.
  Future<void> _loadMoods() async {
    _moods = await moodManager.loadMoods();
    setState(() {}); // 상태 업데이트를 통해 UI를 다시 렌더링합니다.
  }

  // 기분과 메모를 저장하는 비동기 함수입니다.
  Future<void> _saveMood() async {
    await moodManager.saveMoods(_moods);
    _memoController.clear(); // 메모 입력 필드를 초기화합니다.
  }

  // 기분 입력을 위한 다이얼로그를 보여주는 함수입니다.
  Future<void> _showMoodDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // 다이얼로그 바깥을 터치하면 닫힘
      builder: (BuildContext context) {
        return MoodDialog(
          memoController: _memoController,
          onMoodSelected: (mood) {
            setState(() {
              _mood = mood; // 선택된 기분을 상태에 저장
            });
            _saveMood(); // 변경된 기분을 저장
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mood Tracker'), // 앱 바의 타이틀을 설정합니다.
      ),
      body: Column(
        children: [
          MoodCalendar(
            selectedDay: _selectedDay, // 선택된 날짜
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay; // 사용자가 새로운 날짜를 선택하면 상태를 업데이트
              });
              _showMoodDialog(); // 새로운 기분을 입력받기 위한 다이얼로그를 보여줍니다.
            },
            eventLoader: (day) => _moods[day] ?? [], // 해당 날짜의 기분 데이터를 불러옵니다.
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _memoController.dispose(); // 위젯이 제거될 때 메모 컨트롤러를 해제합니다.
    super.dispose();
  }
}
