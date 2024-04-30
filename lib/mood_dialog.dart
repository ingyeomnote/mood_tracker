import 'package:flutter/material.dart';

/*
  MoodDialog는 사용자에게 기분을 입력받기 위한 다이얼로그를 제공하는 StatelessWidget입니다.

  이 위젯은 사용자의 기분을 선택하고 메모를 입력할 수 있는 UI를 제공합니다.
  사용자가 기분을 선택하면 `onMoodSelected` 콜백이 호출됩니다.
*/
class MoodDialog extends StatelessWidget {
  final TextEditingController memoController;  // 메모 입력을 위한 컨트롤러입니다.
  final Function(String) onMoodSelected;       // 기분 선택 시 호출되는 콜백 함수입니다.

  MoodDialog({Key? key, required this.memoController, required this.onMoodSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('How are you feeling?'), // 다이얼로그의 제목입니다.
      content: SingleChildScrollView( // 스크롤 가능한 컨텐츠 영역입니다.
        child: ListBody( // 리스트 아이템들을 세로로 나열합니다.
          children: <Widget>[
            ...['Great', 'Good', 'Okay', 'Bad', 'Terrible'].map(
                  (String mood) => ListTile(
                title: Text(mood),
                onTap: () => onMoodSelected(mood), // 해당 기분을 선택 시 콜백 호출
              ),
            ),
            TextField(
              controller: memoController,
              decoration: InputDecoration(labelText: 'Add a memo...'), // 메모 입력 필드
            ),
          ],
        ),
      ),
      actions: <Widget>[ // 다이얼로그의 하단에 위치할 버튼들입니다.
        TextButton(
          child: Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(), // 취소 버튼
        ),
        TextButton(
          child: Text('Save'),
          onPressed: () {
            Navigator.of(context).pop(); // 저장 버튼
          },
        ),
      ],
    );
  }
}
