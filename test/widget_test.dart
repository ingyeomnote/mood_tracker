import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_test_01/main.dart';

void main() {
  testWidgets('Displays mood dialog and accepts input', (WidgetTester tester) async {
    await tester.pumpWidget(MoodTrackerApp());

    // 다이얼로그를 표시하기 위해 캘린더 날짜 선택
    await tester.tap(find.text('${DateTime.now().day}'));
    await tester.pumpAndSettle();

    // 'Good' 선택 및 메모 입력
    await tester.tap(find.text('Good').last);
    await tester.pump();
    await tester.enterText(find.byType(TextField), 'Testing mood tracker!');
    await tester.pump();

    // 'Save' 버튼을 찾아 탭
    Finder saveButton = find.text('Save').last;
    expect(saveButton, findsOneWidget); // Save 버튼이 있는지 확인
    await tester.ensureVisible(saveButton);  // Save 버튼이 화면에 보이도록 스크롤
    await tester.tap(saveButton);
    await tester.pumpAndSettle();

    // SharedPreferences 데이터 검증
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedData = prefs.getString('moods');
    expect(savedData, isNotNull);  // 저장된 데이터가 null이 아닌지 확인

    Map<String, dynamic> moods = json.decode(savedData!);
    expect(moods.containsKey(DateTime.now().toIso8601String()), isTrue); // 날짜 키가 존재하는지 확인
  });
}