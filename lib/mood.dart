import 'package:flutter/material.dart';

// Mood 모델 정의
class Mood {
  final String mood;
  final String image;

  Mood(this.mood, this.image);
}

const Map<String, String> moodImages = {
  'Great': 'assets/Great.png',
  'Good': 'assets/Good.png',
  'Okay': 'assets/Okay.png',
  'Bad': 'assets/Bad.png',
  'Terrible': 'assets/Terrible.png'
};

// Mood 선택 위젯
class MoodSelector extends StatelessWidget {
  final String? selectedMood;
  final Function(String) onMoodSelected;

  MoodSelector({Key? key, this.selectedMood, required this.onMoodSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListBody(
      children: moodImages.entries.map((entry) => ListTile(
        title: Text(entry.key), // 기분의 이름을 타이틀로 사용
        leading: Image.asset(entry.value, width: 40, height: 40), // 해당 기분의 이미지
        trailing: selectedMood == entry.key ? Icon(Icons.check, color: Colors.green) : null, // 선택된 기분 표시
        tileColor: selectedMood == entry.key ? Colors.lightBlueAccent : Colors.transparent, // 선택된 기분 배경색 변경
        onTap: (){
          onMoodSelected(entry.key); // 탭 시 선택된 기분을 업데이트하고 콜백 함수 호출
        },
      )).toList(),
    );
  }
}