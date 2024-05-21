import 'package:flutter/material.dart';
import 'package:app_test_01/mood_tracker_home_page.dart';
import 'package:google_fonts/google_fonts.dart';

// 애플리케이션의 진입점이다.
void main() => runApp(MoodTrackerApp());

// 애플리케이션의 최상위 위젯을 정의하는 클래스이다.
// StatelessWidget을 상속받아, 상태가 없는 위젯임을 나타낸다.
class MoodTrackerApp extends StatelessWidget {
  // 'Key? : key' : 'Key'는 위젯을 고유하게 식별하는 데 사용되는 객체이다. 특히, flutter의 위젯 트리에서,
  // 'Key'는 동일한 타입의 여러 위젯을 구분하거나 상태를 보존하는 데 사용된다.
  // 이점 : 'Key'는 위젯의 identify를 유지하고, 상태 관리 시 특정 위젯의 상태를 유지하거나 재사용하는 데 도움을 준다.
  // 예를 들어, 'ListView'나 "GridView'와 같은 목록에서 아이템들이 재배치되거나 수정될 때, 각 아이템의 상태를 유지하려면 각 위젯에 고유한 'Key'를 할당한다.
  // 'Key? key'는 Key타입일 수도 있고, null일 수도 있다는 것을 의미한다. -> null safety

  // 'super(key : key)'는 생성자에서 부모 클래스의 생성자를 호출하는 문법
  // 이점 : flutter의 모든 위젯은 'Widget'클래스를 상속받으며, 대부분의 위젯은 부모 클래스에서 'key'매개변수를 받으며,
  // 'super(key : key)'는 현재 클래스의 생성자에서 받은 'key'를 부모 클래스의 생성자로 전달하여, 위젯의 고유 식별자로 설정한다.
  // 동작 : 생성자의 초기화 목록에서 'super(key : key)'를 호출하면, 현재 인스턴스가 생성되기 전에!!
  // 부모 클래스의 생성자가 먼저 실행된다. 이를 통해 부모 클래스가 제대로 초기화 될 수 있다.
  MoodTrackerApp({Key? key}) : super(key : key);
  @override
  Widget build(BuildContext context) {
    // MaterialApp은 Material Design 앱을 생성하기 위한 루트 위젯이다.
    return MaterialApp(
      title: 'Mood Tracker', // 앱의 타이틀을 정의한다.
      theme: ThemeData(
        primarySwatch: Colors.green, // 앱의 기본 색상 테마를 설정한다.
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: MoodTrackerHomePage(), // 앱이 시작될 때 표시될 홈페이지를 지정한다.
    );
  }
}
