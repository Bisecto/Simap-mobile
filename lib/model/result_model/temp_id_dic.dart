class TermsIdDic {
  int first;
  int second;

  TermsIdDic({
    required this.first,
    required this.second,
  });

  factory TermsIdDic.fromJson(Map<String, dynamic> json) => TermsIdDic(
    first: json["first"],
    second: json["second"],
  );

  Map<String, dynamic> toJson() => {
    "first": first,
    "second": second,
  };
}
