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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mood Tracker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Your current mood is:',
            ),
            Text(
              _mood,
              style: Theme.of(context).textTheme.headline4,
            ),
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