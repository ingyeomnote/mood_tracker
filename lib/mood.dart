import 'package:flutter/material.dart';

// Mood 모델 정의
class Mood {
  final String mood;
  final String image;

  Mood(this.mood, this.image);
}

// Mood 선택 위젯
class MoodSelector extends StatelessWidget {
  final String? selectedMood;
  final Function(String) onMoodSelected;

  MoodSelector({Key? key, this.selectedMood, required this.onMoodSelected}) : super(key: key);

  final List<Mood> moods = [
    Mood('Great', 'assets/Great.png'),
    Mood('Good', 'assets/Good.png'),
    Mood('Okay', 'assets/Okay.png'),
    Mood('Bad', 'assets/Bad.png'),
    Mood('Terrible', 'assets/Terrible.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return ListBody(
      children: moods.map((item) => ListTile(
        title: Text(item.mood),
        leading: Image.asset(item.image, width: 40, height: 40),
        trailing: selectedMood == item.mood ? Icon(Icons.check, color: Colors.green) : null,
        tileColor: selectedMood == item.mood ? Colors.lightBlueAccent : Colors.transparent,
        onTap: () => onMoodSelected(item.mood),
      )).toList(),
    );
  }
}