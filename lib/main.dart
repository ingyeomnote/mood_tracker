import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

void main() => runApp(MoodTrackerApp());

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
  String _memo = '';
  DateTime _selectedDay = DateTime.now();
  Map<DateTime, List<dynamic>> _moods = {};

  TextEditingController _memoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadMoods();
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
    });
    _showMoodDialog();
  }

  Future<void> _loadMoods() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _moods = Map<DateTime, List<dynamic>>.from(
        (json.decode(prefs.getString('moods') ?? '{}') as Map).map(
              (key, value) => MapEntry(DateTime.parse(key), value),
        ),
      );
    });
  }

  Future<void> _saveMood() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _moods[_selectedDay] = [_mood, _memoController.text];
      prefs.setString('moods', json.encode(
        _moods.map((key, value) => MapEntry(key.toIso8601String(), value)),
      ));
      _memoController.clear();
    });
  }

  Future<void> _showMoodDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('How are you feeling?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                ...['Great', 'Good', 'Okay', 'Bad', 'Terrible'].map(
                      (String mood) => ListTile(
                    title: Text(mood),
                    onTap: () {
                      setState(() {
                        _mood = mood;
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                TextField(
                  controller: _memoController,
                  decoration: InputDecoration(labelText: 'Add a memo...'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                _saveMood();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mood Tracker'),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: DateTime.now(),
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: _onDaySelected,
            eventLoader: (day) {
              return _moods[day] ?? [];
            },
          ),
          // ... 기분 및 메모 UI 추가
        ],
      ),
      // ... FloatingActionButton 등 추가
    );
  }

  @override
  void dispose() {
    _memoController.dispose();
    super.dispose();
  }
}