import 'package:flutter/material.dart';

/*
  MoodDialog는 사용자에게 기분을 입력받기 위한 다이얼로그를 제공하는 StatelessWidget이다.

  이 위젯은 사용자의 기분을 선택하고 메모를 입력할 수 있는 UI를 제공한다.
  사용자가 기분을 선택하면 `onMoodSelected` 콜백이 호출된다.
*/
class MoodDialog extends StatefulWidget {
  final TextEditingController memoController;  // 메모 입력을 위한 컨트롤러이다.
  final Function(String) onMoodSelected;       // 기분 선택 시 호출되는 콜백 함수이다.
  final VoidCallback onSavePressd;

  // required : dart의 null safety 기능의 일부로, 함수 사용 시 매개변수가 반드시 필요함을 명시한다.
  // required 키워드는 매개변수를 반드시 호출해야함을 강제한다. 이를 통해 런타임 오류를 방지한다.
  // 아래 예시에서 required 키워드는 MoodDialog의 인스턴스가 생성될 때 memoController와 onMoodSelected가 반드시 제공되도록 강제합니다
  MoodDialog({
      Key? key,
      required this.memoController,
      required this.onMoodSelected,
      required this.onSavePressd
      }) : super(key: key);

  @override
  _MoodDialogState createState() => _MoodDialogState();
}

class _MoodDialogState extends State<MoodDialog>{
  String? selectedMood;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('How are you feeling?'), // 다이얼로그의 제목이다.
      content: SingleChildScrollView( // 스크롤 가능한 컨텐츠 영역이다.
        child: ListBody( // 리스트 아이템들을 세로로 나열한다.
          children: <Widget>[
            ...['Great', 'Good', 'Okay', 'Bad', 'Terrible'].map(
                  (String mood) => ListTile(
                title: Text(mood),
                leading: selectedMood == mood? Icon(Icons.check, color: Colors.green) : null, // 선택 표시 추가
                tileColor: selectedMood == mood? Colors.lightBlueAccent : Colors.transparent, // 배경색 변경
                onTap: (){
                  setState(() {
                    selectedMood = mood;
                  });
                  widget.onMoodSelected(mood); // 해당 기분을 선택 시 콜백 호출
                },
              ),
            ),
            TextField(
              controller: widget.memoController,
              decoration: InputDecoration(labelText: 'Add a memo...'), // 메모 입력 필드
            ),
          ],
        ),
      ),
      actions: <Widget>[ // 다이얼로그의 하단에 위치할 버튼들이다.
        TextButton(
          child: Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(), // 취소 버튼
        ),
        TextButton(
          child: Text('Save'),
          onPressed: () {
            widget.onSavePressd();
            Navigator.of(context).pop(); // 저장 버튼
          },
        ),
      ],
    );
  }
}
