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
  final Map<DateTime, String> moodEvents; // 날짜와 감정 이미지를 매핑

  MoodCalendar({
    Key? key,
    required this.selectedDay,
    required this.onDaySelected,
    required this.eventLoader,
    required this.moodEvents,
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

      /*// 캘린더 스타일 커스터마이징
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(
          color: Colors.lightBlueAccent,
          shape: BoxShape.circle,
        ),
        selectedDecoration: BoxDecoration(
          color: Colors.purple,
          shape: BoxShape.circle,
        ),
        defaultDecoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey),
        ),
        weekendDecoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.red),
        ),
        markerDecoration: BoxDecoration(
          color: Colors.black,
          shape: BoxShape.circle,
        ),
        // 기타 스타일 옵션을 추가할 수 있습니다.
      ),*/


/*
      // 캘린더 헤더 스타일 커스터마이징
      headerStyle: HeaderStyle(
        titleCentered: true,
        formatButtonVisible: false,
        titleTextStyle: TextStyle(
          color: Colors.blueAccent,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        leftChevronIcon: Icon(Icons.chevron_left, color: Colors.blueAccent),
        rightChevronIcon: Icon(Icons.chevron_right, color: Colors.blueAccent),
      ),

      // 마커를 세밀하게 조정
      calendarBuilders: CalendarBuilders(
        selectedBuilder: (context, date, _) {
          // 선택된 날짜에 이미지를 사용하도록 구성
          return Container(
            width: 50, // 날짜 셀 크기
            height: 50,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/selected_day_image.png'), // 원하는 이미지 경로
                fit: BoxFit.cover,
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              '${date.day}',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },

        // 이벤트 마커 설정
        markerBuilder: (context, date, events) {
          if (events.isNotEmpty) {
            return Positioned(
              bottom: 1,
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
              ),
            );
          }
          return SizedBox.shrink();
        },
      ),*/

    // 각 날짜에 맞게 감정 상태 이미지를 표시하기 위한 CalendarBuilders
      calendarBuilders: CalendarBuilders(
        markerBuilder: (context, date, events) {
          print("moodEvents : $moodEvents");
          /*print("context : $context, date : $date, events: $events");
          print("moodEvents : $moodEvents");
          print(moodEvents.containsKey(date));*/
          if (moodEvents.containsKey(date)) {
            // 감정 이미지를 `assets` 폴더에서 로드
            return Positioned(
              bottom: 1,
              child: Image.asset(
                moodEvents[date]!,
                width: 24,
                height: 24,
              ),
            );
          }
          return SizedBox.shrink(); // 이벤트가 없으면 빈 위젯 반환
        },
        selectedBuilder: (context, date, _) {
          return Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
            ),
            alignment: Alignment.center,
            child: Text(
              '${date.day}',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
      ),
    );
  }
}
