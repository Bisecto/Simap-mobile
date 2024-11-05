class CurrentData {
  int id;
  Session session;
  //DateTime dateAdded;
  //int currentClass;

  CurrentData({
    required this.id,
    required this.session,
    //required this.dateAdded,
    //required this.currentClass,
  });

  factory CurrentData.fromJson(Map<String, dynamic> json) => CurrentData(
    id: json["id"],
    session: Session.fromJson(json["session"]),
   // dateAdded: DateTime.parse(json["date_added"]),
    //currentClass: json["current_class"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "session": session.toJson(),
    //"date_added": dateAdded.toIso8601String(),
    //"current_class": currentClass,
  };
}

class Session {
  int id;
  String session;
  String sessionSlug;
  bool activeSession;
  int branch;

  Session({
    required this.id,
    required this.session,
    required this.sessionSlug,
    required this.activeSession,
    required this.branch,
  });

  factory Session.fromJson(Map<String, dynamic> json) => Session(
    id: json["id"],
    session: json["session"],
    sessionSlug: json["session_slug"],
    activeSession: json["active_session"],
    branch: json["branch"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "session": session,
    "session_slug": sessionSlug,
    "active_session": activeSession,
    "branch": branch,
  };
}