import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/*
  MoodManager는 기분과 관련된 데이터를 저장하고 로드하는 클래스입니다.
  이 클래스는 SharedPreferences를 사용하여 로컬 스토리지에 데이터를 저장합니다.
*/
class MoodManager {
  /*
    저장된 기분 데이터를 로드합니다.

    이 함수는 SharedPreferences에서 'moods' 키를 사용하여 저장된 데이터를 불러옵니다.
    데이터는 JSON 형식으로 저장되며, 로드 시 Map<DateTime, List<dynamic>>으로 변환됩니다.

    반환값: - Future<Map<DateTime, List<dynamic>>>: 비동기적으로 날짜와 관련된 기분 데이터를 담은 Map을 반환합니다.
  */
  Future<Map<DateTime, List<dynamic>>> loadMoods() async {
    final prefs = await SharedPreferences.getInstance();
    return Map<DateTime, List<dynamic>>.from(
      (json.decode(prefs.getString('moods') ?? '{}') as Map).map(
            (key, value) => MapEntry(DateTime.parse(key), value),
      ),
    );
  }

  /*
    기분 데이터를 저장합니다.
   
    이 함수는 주어진 기분 데이터를 JSON 형식으로 인코딩하고, SharedPreferences에 저장합니다.
    각 기분 데이터는 특정 날짜에 대응되며, 이 날짜는 ISO8601 문자열 형식으로 키로 사용됩니다.
   
    매개변수:
      - moods: 날짜별로 기분과 메모를 포함하는 데이터를 담은 Map입니다.
   
    반환값:
      - Future<void>: 데이터 저장 작업이 완료되었음을 나타내는 Future입니다.
  */
  Future<void> saveMoods(Map<DateTime, List<dynamic>> moods) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('moods', json.encode(
      moods.map((key, value) => MapEntry(key.toIso8601String(), value)),
    ));
  }
}
