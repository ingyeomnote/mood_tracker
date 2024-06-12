import 'package:flutter/material.dart';
import 'mood.dart';

class MoodCount extends StatelessWidget{
final Map<DateTime, String> moodEvents;
Map<String, int> moodCounts = {};
String topMood = '';

MoodCount({
  required this.moodEvents,
});

// 현재는 assets/Good.png (value) 값만 가지고 오고 있는데, date 값도 가져와서
// 24년 6월의 assets/Good.png 의 개수를 파악하고 월별로 카운트 할 수 있게,,
// 24 year 6 month 이렇게 저장하고 만약 이번달의 count navigator을 누르면 year 언제야? 24, month는? 6
// 그럼 24년도 6월의 데이터를 가지고 있는 걸 보여줌?
void _countMoodOccurrences(){
  print("mood event $moodEvents");
  for(var mood in moodEvents.values){
    moodCounts[mood] = (moodCounts[mood] ?? 0) + 1;
  }
}

void _topMood(){
  if (moodCounts.isEmpty) return;

  topMood = moodCounts.entries.reduce((a, b) => a.value > b.value ? a : b).key;
  /*


    moodCounts.entries는 MapEntry 객체의 iterable을 반환한다.
    MapEntry는 key와 value를 포함하는 단일 항목이다.
    ex) [MapEntry('asset/Okay.png', 2), MapEntry('asset/Great.png, 1)]
  */
  /*
    reduce 메서드는 iterable을 순환하면서 특정 조건에 따라 값을 축약한다.
    여기선 두 MapEntry 객체를 비교하며 더 큰 값을 가진 객체를 반환한다.
    reduce 콜백 함수 (a, b) => a.value > b.value ? a : b는 a 와 b 두 개의
    MapEntry를 받아 a.value가 b.value보다 큰 경우 a를 아니면 b를 반환한다.
  */
}

  @override
  Widget build(BuildContext context){
    _countMoodOccurrences();
    _topMood();
    print("count 통계 페이지 $moodCounts");
    print("가장 빈도 수가 높은 감정 $topMood");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mood Count"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(100 ),
        child: Row(
          children: [
            Container(
              width: 200,
              height: 200,
              color: Colors.blue,
              child: Image.asset(topMood),
            ),
            const SizedBox(width: 50), // 이미지 텍스트 사이 간격 조정
            Text(
              "가장 높은 감정: ${moodCounts[topMood]}",
              style: TextStyle(fontSize: 24),
            )
          ],
        )
      ),
    );
    // TODO : implement build
    throw UnimplementedError();
  }
}
