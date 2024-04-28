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
  String _mood = 'Good';
  final TextEditingController _memoController = TextEditingController();

  void _updateMood(String newMood) {
    setState(() {
      _mood = newMood;
    });
  }

  Future<void> _showMoodDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // Dialog to dismiss when tapping outside.
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('How are you feeling?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <String>['Great', 'Good', 'Okay', 'Bad', 'Terrible']
                  .map((String mood) => GestureDetector(
                child: Text(mood),
                onTap: () {
                  _updateMood(mood);
                  Navigator.of(context).pop();
                },
              ))
                  .toList(),
            ),
          ),
        );
      },
    );
  }

  // 새로운 기능: 사용자의 메모를 저장합니다.
  void _saveEntry() {
    final String memoText = _memoController.text;
    if (memoText.isNotEmpty) {
      // 여기서 데이터베이스에 기분과 메모를 저장하는 로직을 추가합니다.
      print('Saving Mood: $_mood, Memo: $memoText'); // 임시 로그 출력
      _memoController.clear(); // 입력 필드를 비웁니다.
    }
  }

  @override
  void dispose() {
    _memoController.dispose(); // 컨트롤러 정리
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mood Tracker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Your current mood is: $_mood',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _memoController,
              decoration: InputDecoration(
                labelText: 'Add a memo about your day...',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveEntry,
              child: Text('Save Entry'),
            ),
            // 여기에 저장된 기분과 메모를 표시하는 위젯을 추가할 수 있습니다.
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showMoodDialog,
        tooltip: 'Record Mood',
        child: Icon(Icons.add),
      ),
    );
  }
}