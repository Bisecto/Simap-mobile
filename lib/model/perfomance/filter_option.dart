class FilterOptions {
  final List<ClassFilter> classes;
  final List<String> terms;
  final List<SessionFilter> sessions;
  final CurrentFilters currentFilters;

  FilterOptions({
    required this.classes,
    required this.terms,
    required this.sessions,
    required this.currentFilters,
  });

  factory FilterOptions.fromJson(Map<String, dynamic> json) {
    return FilterOptions(
      classes: (json['classes'] as List)
          .map((item) => ClassFilter.fromJson(item))
          .toList(),
      terms: List<String>.from(json['terms']),
      sessions: (json['sessions'] as List)
          .map((item) => SessionFilter.fromJson(item))
          .toList(),
      currentFilters: CurrentFilters.fromJson(json['current_filters']),
    );
  }
}
class ClassFilter {
  final int id;
  final String nameOfClassType;

  ClassFilter({
    required this.id,
    required this.nameOfClassType,
  });

  factory ClassFilter.fromJson(Map<String, dynamic> json) {
    return ClassFilter(
      id: json['id'],
      nameOfClassType: json['name_of_class_type'],
    );
  }
}

class SessionFilter {
  final int id;
  final String session;

  SessionFilter({
    required this.id,
    required this.session,
  });

  factory SessionFilter.fromJson(Map<String, dynamic> json) {
    return SessionFilter(
      id: json['id'],
      session: json['session'],
    );
  }
}

class CurrentFilters {
  final String classId;
  final String term;
  final String sessionId;

  CurrentFilters({
    required this.classId,
    required this.term,
    required this.sessionId,
  });

  factory CurrentFilters.fromJson(Map<String, dynamic> json) {
    return CurrentFilters(
      classId: json['class_id'].toString(),
      term: json['term'],
      sessionId: json['session_id'].toString(),
    );
  }

  CurrentFilters copyWith({
    String? classId,
    String? term,
    String? sessionId,
  }) {
    return CurrentFilters(
      classId: classId ?? this.classId,
      term: term ?? this.term,
      sessionId: sessionId ?? this.sessionId,
    );
  }
}