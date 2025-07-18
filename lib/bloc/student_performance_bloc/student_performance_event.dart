// bloc/student_performance_event.dart

import 'package:equatable/equatable.dart';

abstract class StudentPerformanceEvent extends Equatable {
  const StudentPerformanceEvent();

  @override
  List<Object?> get props => [];
}

class LoadStudentPerformance extends StudentPerformanceEvent {
  const LoadStudentPerformance();
}

class LoadStudentsPerformanceInSchool extends StudentPerformanceEvent {
  final String term;
  final String sessionId;
  final String classId;

  const LoadStudentsPerformanceInSchool({
    required this.term,
    required this.sessionId,
    required this.classId,
  });

  @override
  List<Object?> get props => [term, sessionId, classId];
}

class LoadStudentPerformanceBySession extends StudentPerformanceEvent {
  final String sessionId;

  const LoadStudentPerformanceBySession({
    required this.sessionId,
  });

  @override
  List<Object?> get props => [sessionId];
}

class UpdateFilters extends StudentPerformanceEvent {
  final String? term;
  final String? sessionId;
  final String? classId;

  const UpdateFilters({
    this.term,
    this.sessionId,
    this.classId,
  });

  @override
  List<Object?> get props => [term, sessionId, classId];
}

class RefreshData extends StudentPerformanceEvent {
  const RefreshData();
}