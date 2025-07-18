// bloc/student_performance_state.dart

import 'package:equatable/equatable.dart';
import '../../model/perfomance/filter_option.dart';
import '../../model/perfomance/overall_performance.dart';
import '../../model/perfomance/student_performance.dart';
import '../../model/perfomance/student_performance_in_school.dart';

abstract class StudentPerformanceState extends Equatable {
  const StudentPerformanceState();

  @override
  List<Object?> get props => [];
}

class StudentPerformanceInitial extends StudentPerformanceState {
  const StudentPerformanceInitial();
}

class StudentPerformanceLoading extends StudentPerformanceState {
  const StudentPerformanceLoading();
}

class StudentPerformanceLoaded extends StudentPerformanceState {
  final StudentPerformanceComparison? studentPerformance;
  final StudentsPerformanceInSchool? studentsPerformanceInSchool;
  final List<OverallPerformance>? performanceBySession;
  final CurrentFilters? currentFilters;

  const StudentPerformanceLoaded({
    this.studentPerformance,
    this.studentsPerformanceInSchool,
    this.performanceBySession,
    this.currentFilters,
  });

  @override
  List<Object?> get props => [
    studentPerformance,
    studentsPerformanceInSchool,
    performanceBySession,
    currentFilters,
  ];

  StudentPerformanceLoaded copyWith({
    StudentPerformanceComparison? studentPerformance,
    StudentsPerformanceInSchool? studentsPerformanceInSchool,
    List<OverallPerformance>? performanceBySession,
    CurrentFilters? currentFilters,
  }) {
    return StudentPerformanceLoaded(
      studentPerformance: studentPerformance ?? this.studentPerformance,
      studentsPerformanceInSchool: studentsPerformanceInSchool ?? this.studentsPerformanceInSchool,
      performanceBySession: performanceBySession ?? this.performanceBySession,
      currentFilters: currentFilters ?? this.currentFilters,
    );
  }
}

class StudentPerformanceError extends StudentPerformanceState {
  final String message;

  const StudentPerformanceError({required this.message});

  @override
  List<Object?> get props => [message];
}