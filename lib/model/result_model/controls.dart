class Controls {
  int id;
  bool positionField;
  int branch;

  Controls({
    required this.id,
    required this.positionField,
    required this.branch,
  });

  factory Controls.fromJson(Map<String, dynamic> json) => Controls(
    id: json["id"],
    positionField: json["position_field"],
    branch: json["branch"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "position_field": positionField,
    "branch": branch,
  };
}
