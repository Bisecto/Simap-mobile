import 'package:simap/model/perfomance/top_student.dart';

import 'filter_option.dart';

class StudentsPerformanceInSchool {
  final FilterOptions filters;
  final List<TopStudent> topStudents;

  StudentsPerformanceInSchool({
    required this.filters,
    required this.topStudents,
  });

  factory StudentsPerformanceInSchool.fromJson(Map<String, dynamic> json) {
    return StudentsPerformanceInSchool(
      filters: FilterOptions.fromJson(json['filters']),
      topStudents: (json['top_students'] as List)
          .map((item) => TopStudent.fromJson(item))
          .toList(),
    );
  }
}