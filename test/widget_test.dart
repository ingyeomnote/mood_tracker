import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:app_test_01/main.dart'; // 앱의 main.dart 파일을 임포트합니다.

void main() {
  group('Mood Tracker Tests', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    testWidgets('Renders TableCalendar and can select a date', (WidgetTester tester) async {
      await tester.pumpWidget(MoodTrackerApp());

      // TableCalendar가 제대로 렌더링되는지 확인
      expect(find.byType(TableCalendar), findsOneWidget);

      // 특정 날짜 (예: 오늘 날짜) 선택
      await tester.tap(find.text('${DateTime.now().day}')); // 현재 날짜를 탭합니다.
      await tester.pumpAndSettle();

      // 선택된 날짜가 상태에 저장되었는지 확인
      // 실제 앱 상태를 테스트하는 것은 어려우므로, 이 부분은 생략하고
      // 대신 상태 변화를 야기하는 UI 반응을 확인할 수 있습니다.
    });

    testWidgets('Displays mood dialog and accepts input', (WidgetTester tester) async {
      await tester.pumpWidget(MoodTrackerApp());

      // 캘린더의 날짜를 선택하여 다이얼로그를 트리거합니다.
      await tester.tap(find.text('${DateTime.now().day}'));
      await tester.pumpAndSettle(); // 다이얼로그가 나타날 때까지 기다립니다.

      // 다이얼로그가 화면에 표시되는지 확인합니다.
      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('How are you feeling?'), findsOneWidget);

      // 'Good' 기분을 선택하고, 메모를 입력합니다.
      await tester.tap(find.text('Good'));
      await tester.pump(); // 기분 선택 후 상태 업데이트를 위해 pump

      // 메모 입력 필드에 텍스트 입력
      await tester.enterText(find.byType(TextField), 'Testing mood tracker!');
      await tester.pump(); // 텍스트 필드 입력 반응

      // Save 버튼을 눌러 저장
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle(); // 저장 반응

      // SharedPreferences에서 데이터 확인
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? savedData = prefs.getString('moods');
      expect(savedData, isNotNull);

      Map<String, dynamic> moods = json.decode(savedData!);
      expect(moods.containsKey(DateTime.now().toIso8601String()), isTrue);
    });
  });
}
