// bloc/student_performance_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../app_repository/student_performance_repository.dart';
import '../../model/perfomance/filter_option.dart';
import 'student_performance_event.dart';
import 'student_performance_state.dart';

class StudentPerformanceBloc extends Bloc<StudentPerformanceEvent, StudentPerformanceState> {
  final StudentPerformanceRepository repository;
  CurrentFilters? _currentFilters;

  StudentPerformanceBloc({
    required this.repository,
  }) : super(const StudentPerformanceInitial()) {
    on<LoadStudentPerformance>(_onLoadStudentPerformance);
    on<LoadStudentsPerformanceInSchool>(_onLoadStudentsPerformanceInSchool);
    on<LoadStudentPerformanceBySession>(_onLoadStudentPerformanceBySession);
    on<UpdateFilters>(_onUpdateFilters);
    on<RefreshData>(_onRefreshData);
  }

  Future<void> _onLoadStudentPerformance(
      LoadStudentPerformance event,
      Emitter<StudentPerformanceState> emit,
      ) async {
    emit(const StudentPerformanceLoading());

    try {
      final studentPerformance = await repository.getStudentPerformance();

      final currentState = state;
      if (currentState is StudentPerformanceLoaded) {
        emit(currentState.copyWith(studentPerformance: studentPerformance));
      } else {
        emit(StudentPerformanceLoaded(studentPerformance: studentPerformance));
      }
    } catch (e) {
      emit(StudentPerformanceError(message: e.toString()));
    }
  }

  Future<void> _onLoadStudentsPerformanceInSchool(
      LoadStudentsPerformanceInSchool event,
      Emitter<StudentPerformanceState> emit,
      ) async {
    emit(const StudentPerformanceLoading());

    try {
      final studentsPerformance = await repository.getStudentsPerformanceInSchool(
        term: event.term,
        sessionId: event.sessionId,
        classId: event.classId,
      );

      _currentFilters = CurrentFilters(
        term: event.term,
        sessionId: event.sessionId,
        classId: event.classId,
      );

      final currentState = state;
      if (currentState is StudentPerformanceLoaded) {
        emit(currentState.copyWith(
          studentsPerformanceInSchool: studentsPerformance,
          currentFilters: _currentFilters,
        ));
      } else {
        print('Cpoty with debug');

        emit(StudentPerformanceLoaded(
          studentsPerformanceInSchool: studentsPerformance,
          currentFilters: _currentFilters,
        ));
      }
    } catch (e) {
      emit(StudentPerformanceError(message: e.toString()));
    }
  }

  Future<void> _onLoadStudentPerformanceBySession(
      LoadStudentPerformanceBySession event,
      Emitter<StudentPerformanceState> emit,
      ) async {
    emit(const StudentPerformanceLoading());

    try {
      final performanceBySession = await repository.getStudentPerformanceBySession(
        sessionId: event.sessionId,
      );

      final currentState = state;
      if (currentState is StudentPerformanceLoaded) {
        emit(currentState.copyWith(performanceBySession: performanceBySession));
      } else {
        emit(StudentPerformanceLoaded(performanceBySession: performanceBySession));
      }
    } catch (e) {
      emit(StudentPerformanceError(message: e.toString()));
    }
  }

  Future<void> _onUpdateFilters(
      UpdateFilters event,
      Emitter<StudentPerformanceState> emit,
      ) async {
    final currentState = state;
    if (currentState is StudentPerformanceLoaded && _currentFilters != null) {
      final newFilters = _currentFilters!.copyWith(
        term: event.term,
        sessionId: event.sessionId,
        classId: event.classId,
      );

      _currentFilters = newFilters;

      // Reload data with new filters
      add(LoadStudentsPerformanceInSchool(
        term: newFilters.term,
        sessionId: newFilters.sessionId,
        classId: newFilters.classId,
      ));
    }
  }

  Future<void> _onRefreshData(
      RefreshData event,
      Emitter<StudentPerformanceState> emit,
      ) async {
    if (_currentFilters != null) {
      add(LoadStudentPerformance());
      add(LoadStudentsPerformanceInSchool(
        term: _currentFilters!.term,
        sessionId: _currentFilters!.sessionId,
        classId: _currentFilters!.classId,
      ));
      add(LoadStudentPerformanceBySession(sessionId: _currentFilters!.sessionId));
    } else {
      add(LoadStudentPerformance());
    }
  }
}