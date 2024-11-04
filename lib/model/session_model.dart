

class CurrentSessionModel {
  int id;
  String session;
  String sessionSlug;
  bool activeSession;
  int branch;

  CurrentSessionModel({
    required this.id,
    required this.session,
    required this.sessionSlug,
    required this.activeSession,
    required this.branch,
  });

  factory CurrentSessionModel.fromJson(Map<String, dynamic> json) => CurrentSessionModel(
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
