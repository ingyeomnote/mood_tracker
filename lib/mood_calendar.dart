import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

/*
  MoodCalendar는 사용자에게 달력을 보여주고 특정 날짜를 선택할 수 있게 하는 StatelessWidget이다.

  이 위젯은 `TableCalendar`를 사용하여 구현되며, 사용자가 날짜를 선택할 때마다 `onDaySelected` 콜백을 호출한다.
  또한, `eventLoader`는 선택된 날짜에 해당하는 이벤트 데이터를 로드하기 위해 사용된다.
*/
class MoodCalendar extends StatelessWidget {
  final DateTime selectedDay; // 현재 선택된 날짜이다.
  final Function(DateTime, DateTime) onDaySelected; // 날짜 선택 시 호출되는 콜백 함수이다.
  final List<dynamic> Function(DateTime) eventLoader; // 이벤트 로드 함수이다.

  MoodCalendar({
    Key? key,
    required this.selectedDay,
    required this.onDaySelected,
    required this.eventLoader,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.utc(2010, 10, 16), // 달력의 시작 날짜이다.
      lastDay: DateTime.utc(2030, 3, 14),   // 달력의 마지막 날짜이다.
      focusedDay: DateTime.now(),           // 현재 초점이 맞춰진 날짜이다.
      selectedDayPredicate: (day) => isSameDay(selectedDay, day), // 선택된 날짜를 결정하는 함수이다.
      onDaySelected: onDaySelected, // 날짜를 선택할 때 호출되는 콜백 함수이다.
      eventLoader: eventLoader, // 선택된 날짜의 이벤트를 로드하는 함수이다.
    );
  }
}
