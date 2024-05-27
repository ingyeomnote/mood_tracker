import 'package:flutter/material.dart';
import 'mood.dart';

class MoodDialog extends StatefulWidget {
  final TextEditingController memoController;
  final Function(String) onMoodSelected;
  final VoidCallback onSavePressed;

  MoodDialog({
    Key? key,
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
  Widget build(BuildContext context) {
    print("mood_dialog의 context $context");
    return AlertDialog(
      title: Text('How are you feeling?'),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            MoodSelector(selectedMood: selectedMood, onMoodSelected: (mood) {
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