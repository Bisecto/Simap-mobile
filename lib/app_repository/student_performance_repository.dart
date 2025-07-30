
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:simap/app_repository/repository.dart';
import '../model/perfomance/overall_performance.dart';
import '../model/perfomance/student_performance.dart';
import '../model/perfomance/student_performance_in_school.dart';
import '../res/apis.dart';
import '../res/app_strings.dart';
import '../res/shared_preferenceKey.dart';
import '../utills/app_utils.dart';
import '../utills/shared_preferences.dart';

class StudentPerformanceRepository {
  final AppRepository _appRepository;
  StudentPerformanceRepository({
    required AppRepository appRepository,
  }) : _appRepository = appRepository;
String baseUrl='https://uhs.myeduportal.net';
  Future<StudentPerformanceComparison> getStudentPerformance() async {
    try {
      String token =
      await SharedPref.getString(SharedPreferenceKey().accessTokenKey);
      final apiUrl = '$baseUrl/endpoint/student-performance/';
      final response = await _appRepository.getRequestWithToken(token, apiUrl);
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        print(response.body);
        return StudentPerformanceComparison.fromJson(jsonData);
      } else {
        throw Exception('Failed to load student performance: ${response.statusCode}');
      }
    } catch (e) {
      AppUtils().debuglog('Error in getStudentPerformance: $e');
      throw Exception('Network error: $e');
    }
  }

  Future<StudentsPerformanceInSchool> getStudentsPerformanceInSchool({
    required String term,
    required String sessionId,
    required String classId,
  }) async {
    try {
      String token =
      await SharedPref.getString(SharedPreferenceKey().accessTokenKey);
      final apiUrl = '$baseUrl/endpoint/students-performance-in-school/?term=$term&session_id=$sessionId&class_id=$classId';
      final response = await _appRepository.getRequestWithToken(token, apiUrl);
      print(response.statusCode);

      print(response.body);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return StudentsPerformanceInSchool.fromJson(jsonData);
      } else {
        throw Exception('Failed to load students performance in school: ${response.statusCode}');
      }
    } catch (e) {
      AppUtils().debuglog('Error in getStudentsPerformanceInSchool: $e');
      throw Exception('Network error: $e');
    }
  }

  Future<List<OverallPerformance>> getStudentPerformanceBySession({
    required String sessionId,
  }) async {
    try {
      String token =
      await SharedPref.getString(SharedPreferenceKey().accessTokenKey);
      final apiUrl = '$baseUrl/student-performance-by-session/?session_id=$sessionId';
      final response = await _appRepository.getRequestWithToken(token, apiUrl);


      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        print('Failed to load student performance by session: ${json.decode(response.body)}');

        return (jsonData as List)
            .map((item) => OverallPerformance.fromJson(item))
            .toList();
      } else {
        throw Exception('Failed to load student performance by session: ${response.statusCode}');
      }
    } catch (e) {
      AppUtils().debuglog('Error in getStudentPerformanceBySession: $e');
      throw Exception('Network error: $e');
    }
  }
}

