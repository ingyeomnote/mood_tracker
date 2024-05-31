import 'package:flutter/material.dart';
import 'mood.dart';

class MoodCount extends StatelessWidget{
final Map<DateTime, String> moodEvents;
Map<String, int> moodCounts = {};

MoodCount({
  required this.moodEvents,
});

  @override
  Widget build(BuildContext context){
    print("count 통계 페이지");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mood Count"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(100 ),
        child: Container(
          width: 200,
          height: 200,
          color: Colors.blue,
          child: const Center(
            child: Text(
              'Hello, Flutter',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );

    // TODO : implement build
    throw UnimplementedError();
  }
}
