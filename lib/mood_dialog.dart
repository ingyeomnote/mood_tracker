import 'package:flutter/material.dart';
import 'mood.dart';

class MoodDialog extends StatefulWidget {
  final String initialMood;
  final TextEditingController memoController;
  final Function(String) onMoodSelected;
  final VoidCallback onSavePressed;

  MoodDialog({
    Key? key,
    required this.initialMood,
    required this.memoController,
    required this.onMoodSelected,
    required this.onSavePressed,
  }) : super(key: key);

  @override
  _MoodDialogState createState() => _MoodDialogState();
}

class _MoodDialogState extends State<MoodDialog> {
  String? selectedMood;

  @override
  void initState(){ //이 메서드는 상태 초기화, 컨트롤러 초기화, 데이터 로딩 등과 같은 작업을 수행하기에 적합한 위치입니다.
    super.initState(); // 부모 클래스의 initState() 함수 호출(필수)
    selectedMood = widget.initialMood;
  }

  @override
  Widget build(BuildContext context) {
    print("mood_dialog의 context $context");
    return AlertDialog(
      title: Text('How are you feeling?'),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            MoodSelector(selectedMood: selectedMood, onMoodSelected: (mood) {
              print("과거 $selectedMood, $mood");
              setState(() {
                selectedMood = mood;
              });
              widget.onMoodSelected(mood);
            }),
            TextField(
              controller: widget.memoController,
              decoration: InputDecoration(labelText: 'Add a memo...'),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: Text('Save'),
          onPressed: () {
            widget.onSavePressed();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}